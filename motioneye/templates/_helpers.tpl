{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "motioneye.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "motioneye.fullname" -}}
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
{{- define "motioneye.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "motioneye.labels" -}}
helm.sh/chart: {{ include "motioneye.chart" . }}
{{ include "motioneye.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "motioneye.selectorLabels" -}}
app.kubernetes.io/name: {{ include "motioneye.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "motioneye.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "motioneye.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Gets the image Tag to use when pulling the docker image
*/}}
{{- define "motioneye.imageTag" -}}
{{- if .Values.image.tag -}}
{{ .Values.image.tag }}
{{- else -}}
{{ .Chart.AppVersion }}
{{- end -}}
{{- end -}}

{{/*
Sets the name of the config PVC
*/}}
{{- define "motioneye.configPVCName" -}}
{{- if .Values.persistence.config.existingClaim -}}
{{ .Values.persistence.config.existingClaim }}
{{- else -}}
{{ include "motioneye.fullname" . }}-config
{{- end -}}
{{- end -}}

{{/*
Sets the name of the data PVC
*/}}
{{- define "motioneye.dataPVCName" -}}
{{- if .Values.persistence.data.existingClaim -}}
{{ .Values.persistence.data.existingClaim }}
{{- else -}}
{{ include "motioneye.fullname" . }}-data
{{- end -}}
{{- end -}}