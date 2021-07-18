package org.acme.rest;

import io.quarkus.test.junit.QuarkusTest;
import org.junit.jupiter.api.Test;

import static io.restassured.RestAssured.given;
import static org.hamcrest.CoreMatchers.is;

@QuarkusTest
public class EnvironmentResourceTest {

    @Test
    public void testHelloEndpoint() {
        given()
          .when().get("/envvariables")
          .then()
             .statusCode(200)
             .body(is("Database URL: postgres://postgre@postgres-svc:5432/localdb"));
    }

}