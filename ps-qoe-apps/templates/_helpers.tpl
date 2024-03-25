{{/*
Create robustName that can be used as Kubernetes resource name, and as subdomain as well
\w – Latin letters, digits, underscore '_' .
\W – all but \w .
*/}}
{{- define "robustName" -}}
{{ regexReplaceAll "\\W+" . "-" | replace "_" "-" | lower | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Expand the name of the chart.
*/}}
{{- define "ps-qoe-apps.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "ps-qoe-apps.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "ps-qoe-apps.selectorLabels" -}}
app.kubernetes.io/name: {{ include "ps-qoe-apps.name" . }}
app.kubernetes.io/instance: {{ template "robustName" .Release.Name }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "ps-qoe-apps.labels" -}}
helm.sh/chart: {{ include "ps-qoe-apps.chart" . }}
{{ include "ps-qoe-apps.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}