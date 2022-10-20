package org.ehrbase.fhirbridge;

import org.junit.jupiter.api.TestInstance;
import org.springframework.test.context.DynamicPropertyRegistry;
import org.springframework.test.context.DynamicPropertySource;
import org.testcontainers.containers.GenericContainer;
import org.testcontainers.containers.Network;
import org.testcontainers.containers.wait.strategy.Wait;
import org.testcontainers.utility.DockerImageName;

@TestInstance(TestInstance.Lifecycle.PER_CLASS)
public class AbstractIntegrationTest {

    private static final int EHRBASE_SERVICE_PORT = 8080;

    private static final GenericContainer<?> ehrbaseContainer;

    static {
        Network ehrbaseNetwork = Network.newNetwork();
        GenericContainer<?> ehrbaseDatabaseContainer =
                new GenericContainer<>(DockerImageName.parse("ehrbase/ehrbase-postgres:13.4"))
                        .withNetwork(ehrbaseNetwork)
                        .withNetworkAliases("ehrbase-database")
                        .withEnv("POSTGRES_USER", "postgres")
                        .withEnv("POSTGRES_PASSWORD", "postgres")
                        .withEnv("EHRBASE_USER", "ehrbase")
                        .withEnv("EHRBASE_PASSWORD", "ehrbase")
                        .waitingFor(Wait.forLogMessage(".*database system is ready to accept connections.*", 2));
        ehrbaseDatabaseContainer.start();
        ehrbaseContainer = new GenericContainer<>(DockerImageName.parse("ehrbase/ehrbase:0.19.0"))
                .dependsOn(ehrbaseDatabaseContainer)
                .withNetwork(ehrbaseNetwork)
                .withEnv("DB_URL", "jdbc:postgresql://ehrbase-database:5432/ehrbase")
                .withEnv("DB_USER", "ehrbase")
                .withEnv("DB_PASS", "ehrbase")
                .withEnv("AUTH_TYPE", "BASIC")
                .withEnv("AUTH_USER", "ehrbase-user")
                .withEnv("AUTH_PASSWORD", "SuperSecretPassword")
                .withEnv("SYSTEM_NAME", "local.ehrbase.org")
                .withExposedPorts(EHRBASE_SERVICE_PORT)
                .waitingFor(Wait.forLogMessage(".*Started EhrBase in.*", 1));
        ehrbaseContainer.start();
    }

    @DynamicPropertySource
    private static void setProperties(DynamicPropertyRegistry registry) {
        registry.add("ehrbase.address", ehrbaseContainer::getHost);
        registry.add("ehrbase.port", () -> ehrbaseContainer.getMappedPort(EHRBASE_SERVICE_PORT));
        registry.add("ehrbase.path", () -> "/ehrbase/rest/openehr/v1/");
    }

}
