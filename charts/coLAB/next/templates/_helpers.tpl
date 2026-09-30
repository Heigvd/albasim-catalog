{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "colab.fullname" -}}
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
Name of the Secret holding the database and default-admin passwords.
Both live in one Secret, so the knob is top-level rather than under db.
*/}}
{{- define "colab.credsSecretName" -}}
{{- .Values.existingSecret | default (printf "%s-secret" (include "colab.fullname" .)) -}}
{{- end -}}

{{/*
Name of the Secret holding colab.properties.
*/}}
{{- define "colab.propertiesSecretName" -}}
{{- .Values.colab.existingPropertiesSecret | default (printf "%s-properties" (include "colab.fullname" .)) -}}
{{- end -}}

{{/*
Name of the Secret holding the backup S3 credentials.
*/}}
{{- define "colab.backupSecretName" -}}
{{- .Values.backup.existingSecret | default (printf "%s-backup-secret" (include "colab.fullname" .)) -}}
{{- end -}}
