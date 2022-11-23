{{/*
Expand the name of the chart.
*/}}
{{- define "deploy-agent.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "deploy-agent.fullname" -}}
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
{{- define "deploy-agent.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "deploy-agent.labels" -}}
helm.sh/chart: {{ include "deploy-agent.chart" . }}
{{ include "deploy-agent.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "deploy-agent.selectorLabels" -}}
app.kubernetes.io/name: {{ include "deploy-agent.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "deploy-agent.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "deploy-agent.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the Builkit config file
*/}}
{{- define "deploy-agent.buildkitConfigName" -}}
{{- printf "%s-%s" (include "deploy-agent.fullname" .) "buildkit-config" }}
{{- end }}

{{/*
Create the name of the Docker Config secret name
*/}}
{{- define "deploy-agent.dockerConfigName" -}}
{{- printf "%s-%s" (include "deploy-agent.fullname" .) "docker-config" }}
{{- end }}
