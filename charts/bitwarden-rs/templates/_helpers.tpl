{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "bitwarden-rs.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "bitwarden-rs.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "bitwarden-rs.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "bitwarden-rs.labels" -}}
helm.sh/chart: {{ include "bitwarden-rs.chart" . }}
{{ include "bitwarden-rs.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "bitwarden-rs.selectorLabels" -}}
app.kubernetes.io/name: {{ include "bitwarden-rs.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "bitwarden-rs.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "bitwarden-rs.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Gets the image Tag to use when pulling the docker image
*/}}
{{- define "bitwarden-rs.imageTag" -}}
{{- if .Values.image.tag -}}
{{ .Values.image.tag }}
{{- else -}}
{{ .Chart.AppVersion }}
{{- end -}}
{{- end -}}

{{/*
Returns the Bitwarden_rs URL
*/}}
{{- define "bitwarden-rs.url" -}}
{{- if .Values.bitwardenConfig.domain }}
  {{- .Values.bitwardenConfig.domain }}
{{- else }}
  {{- if .Values.ingress.enabled }}
    {{- if .Values.ingress.tls }}
      {{- printf "https://%s" (index .Values.ingress.hosts 0).host -}}
    {{- else }}
      {{- printf "http://%s" (index .Values.ingress.hosts 0).host -}}
    {{- end }}
  {{- else }}
    {{- printf "http://%s:%s" (include "bitwarden-rs.fullname" .) (toString .Values.service.port) -}}
  {{- end}}
{{- end}}
{{- end -}}