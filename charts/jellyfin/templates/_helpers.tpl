{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "jellyfin.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "jellyfin.fullname" -}}
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
{{- define "jellyfin.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "jellyfin.labels" -}}
helm.sh/chart: {{ include "jellyfin.chart" . }}
{{ include "jellyfin.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "jellyfin.selectorLabels" -}}
app.kubernetes.io/name: {{ include "jellyfin.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "jellyfin.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "jellyfin.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Sets the name of the media PVC
*/}}
{{- define "jellyfin.mediaPVCName" -}}
{{- if .Values.persistence.media.pvc.existingClaim -}}
{{ .Values.persistence.media.pvc.existingClaim }}
{{- else -}}
{{ include "jellyfin.fullname" . }}-media
{{- end -}}
{{- end -}}

{{/*
Sets the name of the config PVC
*/}}
{{- define "jellyfin.configPVCName" -}}
{{- if .Values.persistence.config.existingClaim -}}
{{ .Values.persistence.config.existingClaim }}
{{- else -}}
{{ include "jellyfin.fullname" . }}-config
{{- end -}}
{{- end -}}

{{/*
Sets the name of the config PVC
*/}}
{{- define "jellyfin.cachePVCName" -}}
{{- if .Values.persistence.cache.existingClaim -}}
{{ .Values.persistence.cache.existingClaim }}
{{- else -}}
{{ include "jellyfin.fullname" . }}-cache
{{- end -}}
{{- end -}}

{{/*
Gets the image Tag to use when pulling the docker image
*/}}
{{- define "jellyfin.imageTag" -}}
{{- if .Values.image.tag -}}
{{ .Values.image.tag }}
{{- else -}}
{{ .Chart.AppVersion }}
{{- end -}}
{{- end -}}