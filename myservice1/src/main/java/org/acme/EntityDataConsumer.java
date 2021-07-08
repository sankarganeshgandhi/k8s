package org.acme;

import io.smallrye.reactive.messaging.kafka.Record;
import org.eclipse.microprofile.reactive.messaging.Incoming;
import org.jboss.logging.Logger;

import javax.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class EntityDataConsumer {

    private final Logger logger = Logger.getLogger(EntityDataConsumer.class);

    @Incoming("entitydata-in")
    public void receive(Record<Integer, String> record) {
        logger.infof("Got a movie: %d - %s", record.key(), record.value());
    }
}