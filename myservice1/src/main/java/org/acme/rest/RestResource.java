package org.acme.rest;

import org.acme.*;
import javax.inject.Inject;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.acme.EntityDataProducer;

@Path("/")
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
public class RestResource {

    @Inject
    EntityDataProducer producer;

    @POST
    public Response send(EntityData entityData) {
        producer.sendEntityDataToKafka(entityData);
        // Return an 202 - Accepted response.
        return Response.accepted().build();
    }
}