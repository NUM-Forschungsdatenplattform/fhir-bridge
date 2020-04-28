package org.ehrbase.fhirbridge;

import ca.uhn.fhir.context.FhirContext;
import ca.uhn.fhir.rest.api.MethodOutcome;
import ca.uhn.fhir.rest.client.api.IGenericClient;
import ca.uhn.fhir.rest.server.exceptions.UnprocessableEntityException;
import ca.uhn.fhir.util.OperationOutcomeUtil;
import org.apache.commons.io.IOUtils;
import org.hl7.fhir.r4.model.Observation;
import org.hl7.fhir.r4.model.OperationOutcome;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.web.server.LocalServerPort;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.util.Date;

/**
 * Integration Tests
 */
@ExtendWith(SpringExtension.class)
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
public class FhirBridgeApplicationIT {

    @LocalServerPort
    private int port;

    @Autowired
    private FhirContext context;

    @Autowired
    private ResourceLoader resourceLoader;

    private IGenericClient client;

    @BeforeEach
    public void setUp() {
        context.getRestfulClientFactory().setSocketTimeout(60 * 1000);
        client = context.newRestfulGenericClient("http://localhost:" + port + "/fhir-bridge/fhir");
    }

    @Test
    public void createCondition() throws IOException {
        Date now = new Date();
        MethodOutcome outcome = client.create()
                .resource(getContent("classpath:/Condition/condition-example.json"))
                .execute();

        Assertions.assertEquals(1L, outcome.getId().getIdPartAsLong());
        Assertions.assertEquals(true, outcome.getCreated());
        Assertions.assertNotNull(outcome.getResource());
        Assertions.assertTrue(outcome.getResource().getMeta().getLastUpdated().after(now));
        Assertions.assertEquals("1", outcome.getResource().getMeta().getVersionId());
    }

    @Test
    public void createConditionUsingWrongProfile() {
        UnprocessableEntityException exception = Assertions.assertThrows(UnprocessableEntityException.class,
                () -> client.create()
                        .resource(getContent("classpath:/Condition/condition-invalid-profile.json"))
                        .execute());

        Assertions.assertEquals("Profile mismatch on type for https://www.medizininformatik-initiative.de/fhir/core/StructureDefinition/ObservationLab: " +
                "the profile constrains Observation but the element is Condition", OperationOutcomeUtil.getFirstIssueDetails(context, exception.getOperationOutcome()));
    }

    @Test
    public void createDiagnosticReportLab() throws IOException {
        Date now = new Date();
        MethodOutcome outcome = client.create()
                .resource(getContent("classpath:/DiagnosticReport/diagnosticreport-example-diagnosticreportlab.json"))
                .execute();

        Assertions.assertEquals(1L, outcome.getId().getIdPartAsLong());
        Assertions.assertEquals(true, outcome.getCreated());
        Assertions.assertNotNull(outcome.getResource());
        Assertions.assertTrue(outcome.getResource().getMeta().getLastUpdated().after(now));
        Assertions.assertEquals("1", outcome.getResource().getMeta().getVersionId());
    }

    @Test
    public void createDiagnosticReportWithoutProfile() {
        UnprocessableEntityException exception = Assertions.assertThrows(UnprocessableEntityException.class,
                () -> client.create()
                        .resource(getContent("classpath:/DiagnosticReport/diagnosticreport-default-profile.json"))
                        .execute());

        OperationOutcome outcome = (OperationOutcome) exception.getOperationOutcome();
        Assertions.assertEquals(1, outcome.getIssue().size());
        Assertions.assertEquals("Default profile is not supported for DiagnosticReport. One of the following profiles is expected: " +
                "[https://www.medizininformatik-initiative.de/fhir/core/StructureDefinition/DiagnosticReportLab]", OperationOutcomeUtil.getFirstIssueDetails(context,
                exception.getOperationOutcome()));
    }

    @Test
    public void createOperationLab() throws IOException {
        MethodOutcome methodOutcome = client.create()
                .resource(getContent("classpath:/Observation/observation-example-observationlab.json"))
                .execute();

        Assertions.assertEquals(true, methodOutcome.getCreated());
        Assertions.assertTrue(methodOutcome.getResource() instanceof Observation);
        Assertions.assertNotNull(methodOutcome.getResource());
        Assertions.assertEquals("1", methodOutcome.getResource().getMeta().getVersionId());

    }

    @Test
    public void createCoronavirusNachweis() throws IOException {
        MethodOutcome methodOutcome = client.create()
                .resource(getContent("classpath:/Observation/observation-example-coronavirusnachweistest.json"))
                .execute();

        Assertions.assertEquals(true, methodOutcome.getCreated());
        Assertions.assertTrue(methodOutcome.getResource() instanceof Observation);
        Assertions.assertNotNull(methodOutcome.getResource());
        Assertions.assertEquals("1", methodOutcome.getResource().getMeta().getVersionId());
    }

    @Test
    public void createCoronavirusNachweisFailed() {
        UnprocessableEntityException exception = Assertions.assertThrows(UnprocessableEntityException.class,
                () -> client.create()
                        .resource(getContent("classpath:/Observation/observation-example-bloodpresure.json"))
                        .execute());

        OperationOutcome operationOutcome = (OperationOutcome) exception.getOperationOutcome();
        Assertions.assertEquals(1, operationOutcome.getIssue().size());
    }

    private String getContent(String location) throws IOException {
        Resource resource = resourceLoader.getResource(location);
        try (InputStream input = resource.getInputStream()) {
            return IOUtils.toString(input, StandardCharsets.UTF_8);
        }
    }
}
