{{/*
Expand the name of the chart.
*/}}

{{- define "kafka_cluster1.kafka-server.name" -}}
{{- default "kafka-server1" .Values.kafka_cluster1.server.name }}
{{- end }}

{{- define "kafka_cluster2.kafka-server.name" -}}
{{- default "kafka-server2" .Values.kafka_cluster2.server.name }}
{{- end }}