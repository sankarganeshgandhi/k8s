package org.acme.rest;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import org.eclipse.microprofile.config.inject.ConfigProperty;

@Path("/envvariables")
public class EnvironmentResource {

    @ConfigProperty(name="svc.database.url", defaultValue="not set")
    String databaseURL;

    @ConfigProperty(name="username", defaultValue="not set")
    String userNameFromEnv;

    @GET
    @Produces(MediaType.TEXT_PLAIN)
    public String getEnvVariables() {
        String envVariables = "Database URL: " + databaseURL + ";userName: " + userNameFromEnv;
        return "Env Variables: " + envVariables;
    }
}