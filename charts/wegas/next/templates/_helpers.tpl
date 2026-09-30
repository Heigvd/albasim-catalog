{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "wegas.fullname" -}}
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
Name of the Secret holding the database password.
Defaults to the chart-managed one; overridden by db.existingSecret.
*/}}
{{- define "wegas.dbSecretName" -}}
{{- .Values.db.existingSecret | default (printf "%s-secret" (include "wegas.fullname" .)) -}}
{{- end -}}

{{/*
Name of the Secret holding wegas.properties.
*/}}
{{- define "wegas.propertiesSecretName" -}}
{{- .Values.wegas.existingPropertiesSecret | default (printf "%s-properties" (include "wegas.fullname" .)) -}}
{{- end -}}

{{/*
Name of the Secret holding the backup S3 credentials.
*/}}
{{- define "wegas.backupSecretName" -}}
{{- .Values.backup.existingSecret | default (printf "%s-backup-secret" (include "wegas.fullname" .)) -}}
{{- end -}}
