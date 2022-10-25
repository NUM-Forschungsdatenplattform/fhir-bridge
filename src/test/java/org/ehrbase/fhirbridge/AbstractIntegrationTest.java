package org.ehrbase.fhirbridge;

import org.junit.jupiter.api.TestInstance;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.DynamicPropertyRegistry;
import org.springframework.test.context.DynamicPropertySource;
import org.testcontainers.containers.GenericContainer;
import org.testcontainers.containers.Network;
import org.testcontainers.containers.wait.strategy.Wait;
import org.testcontainers.utility.DockerImageName;

@TestInstance(TestInstance.Lifecycle.PER_CLASS)
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.DEFINED_PORT)
public class AbstractIntegrationTest {

    private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(AbstractIntegrationTest.class);

    private static GenericContainer<?> ehrbaseContainer;

    private static boolean useTestContainers = true;

    static {
        String useTestContainersEnv = System.getenv("USETESTCONTAINERS");
        if (useTestContainersEnv != null) {
            useTestContainers = Boolean.parseBoolean(useTestContainersEnv);
        }

        if (useTestContainers) {
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

            log.info("Starting EHRbase database...");
            ehrbaseDatabaseContainer.start();
            log.info("EHRbase database started.");

            ehrbaseContainer = new GenericContainer<>(DockerImageName.parse("ehrbase/ehrbase:0.17.2"))
                    .dependsOn(ehrbaseDatabaseContainer)
                    .withNetwork(ehrbaseNetwork)
                    .withEnv("DB_URL", "jdbc:postgresql://ehrbase-database:5432/ehrbase")
                    .withEnv("DB_USER", "ehrbase")
                    .withEnv("DB_PASS", "ehrbase")
                    .withEnv("AUTH_TYPE", "BASIC")
                    .withEnv("AUTH_USER", "ehrbase-user")
                    .withEnv("AUTH_PASSWORD", "SuperSecretPassword")
                    .withEnv("SYSTEM_NAME", "local.ehrbase.org")
                    .withExposedPorts(8080)
                    .waitingFor(Wait.forLogMessage(".*Started EhrBase in.*", 1));

            log.info("Starting EHRbase...");
            ehrbaseContainer.start();
            log.info("EHRbase started.");
        }
    }

    @DynamicPropertySource
    private static void setProperties(DynamicPropertyRegistry registry) {
        if (useTestContainers) {
            registry.add("ehrbase.address", ehrbaseContainer::getHost);
            registry.add("ehrbase.port", () -> ehrbaseContainer.getMappedPort(8080));
            registry.add("ehrbase.path", () -> "/ehrbase/rest/openehr/v1/");
        }
    }

}
