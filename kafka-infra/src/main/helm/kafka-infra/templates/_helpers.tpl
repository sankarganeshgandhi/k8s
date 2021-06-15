{{/*
Expand the name of the chart.
*/}}
{{- define "multikafka-infra.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "multikafka-infra.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "multikafka-infra.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "multikafka-infra.labels" -}}
helm.sh/chart: {{ include "multikafka-infra.chart" . }}
{{ include "multikafka-infra.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "multikafka-infra.selectorLabels" -}}
app.kubernetes.io/name: {{ include "multikafka-infra.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: {{ include "multikafka-infra.name" . }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "multikafka-infra.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "multikafka-infra.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}


{{- define "kafka_cluster1.kafka-server.name" -}}
{{- default "kafka-server1" .Values.kafka_cluster1.server.name }}
{{- end }}

{{- define "kafka_cluster2.kafka-server.name" -}}
{{- default "kafka-server2" .Values.kafka_cluster2.server.name }}
{{- end }}