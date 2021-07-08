package org.acme;

import io.smallrye.reactive.messaging.kafka.Record;
import org.eclipse.microprofile.reactive.messaging.Channel;
import org.eclipse.microprofile.reactive.messaging.Emitter;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;

@ApplicationScoped
public class EntityDataProducer {

    @Inject @Channel("entitydata-out")
    Emitter<Record<Integer, String>> emitter;

    public void sendEntityDataToKafka(EntityData entityData) {
        emitter.send(Record.of(entityData.id, entityData.description));
    }
}