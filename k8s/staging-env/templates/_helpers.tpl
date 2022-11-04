{{/*
Expand the name of the chart.
*/}}
{{- define "staging-env.name" -}}
{{- default .Values.name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Expand the name of the chart and ignore potential `.nameOverride`
*/}}
{{- define "staging-env.strictName" -}}
{{- $.Values.name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/* Tag for the echo-server docker image */}}
{{- define "staging-env.echoServerTag" }}
{{- if $.Values.staging.tag }}
    {{- if $.Values.staging.enabled.echoServer }}
        {{- $.Values.staging.tag }}
    {{- else }}
        {{- $.Values.image.tag }}
    {{- end }}
{{- else }}
    {{- $.Values.image.tag }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "staging-env.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "staging-env.labels" -}}
helm.sh/chart: {{ include "staging-env.chart" . }}
{{ include "staging-env.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "staging-env.selectorLabels" -}}
app.kubernetes.io/name: {{ include "staging-env.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
