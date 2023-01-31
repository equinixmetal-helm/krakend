{{/*
Expand the name of the chart.
*/}}
{{- define "krakend.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "krakend.fullname" -}}
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
{{- define "krakend.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "krakend.labels" -}}
helm.sh/chart: {{ include "krakend.chart" . }}
{{ include "krakend.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "krakend.selectorLabels" -}}
app.kubernetes.io/name: {{ include "krakend.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "krakend.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "krakend.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Get krakend files directory
*/}}
{{- define "krakend.FilesDir" -}}
{{- printf "/etc/krakend-src" -}}
{{- end }}

{{/*
Get krakend config file directory
*/}}
{{- define "krakend.configFileDir" -}}
{{- printf "%s/config" (include "krakend.FilesDir" .) -}}
{{- end }}

{{/*
Get krakend config file name
*/}}
{{- define "krakend.configFileName" -}}
{{- printf "krakend.tmpl" -}}
{{- end }}

{{/*
Get krakend config file path
*/}}
{{- define "krakend.configFilePath" -}}
{{- printf "%s/%s" (include "krakend.configFileDir" .) (include "krakend.configFileName" .) -}}
{{- end }}

{{/*
Get krakend settings directory path
*/}}
{{- define "krakend.settingsDir" -}}
{{- printf "%s/settings" (include "krakend.FilesDir" .) -}}
{{- end }}

{{/*
Get krakend partials directory path
*/}}
{{- define "krakend.partialsDir" -}}
{{- printf "%s/partials" (include "krakend.FilesDir" .) -}}
{{- end }}

{{/*
Get krakend templates directory path
*/}}
{{- define "krakend.templatesDir" -}}
{{- printf "%s/templates" (include "krakend.FilesDir" .) -}}
{{- end }}