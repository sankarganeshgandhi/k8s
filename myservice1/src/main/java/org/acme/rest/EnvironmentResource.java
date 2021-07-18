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

    @GET
    @Produces(MediaType.TEXT_PLAIN)
    public String getEnvVariables() {
        return "Database URL: " + databaseURL;
    }
}