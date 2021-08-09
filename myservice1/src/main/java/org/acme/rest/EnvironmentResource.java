package org.acme.rest;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import org.eclipse.microprofile.config.inject.ConfigProperty;


@Path("/envvariables")
public class EnvironmentResource {
    private final static String SECRET_DB_USERNAME = "username";
    private final static String SECRET_DB_PASSWORD = "password";

    @ConfigProperty(name="svc.database.url", defaultValue="not set")
    String databaseURL;

    @ConfigProperty(name=SECRET_DB_USERNAME, defaultValue="not set")
    String dbUserNameSecret;

    @ConfigProperty(name=SECRET_DB_PASSWORD, defaultValue="not set")
    String dbPasswordSecret;

    @GET
    @Produces(MediaType.TEXT_PLAIN)
    public String getEnvVariables() {
        String envVariables = "Database URL: " + databaseURL + 
                                ";dbUserName: " + dbUserNameSecret +
                                ";dbPassword: " + dbPasswordSecret;
        return "Environment Variables: " + envVariables;
    }
}