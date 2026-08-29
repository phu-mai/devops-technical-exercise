{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "devops-test.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "devops-test.labels" -}}
helm.sh/chart: {{ include "devops-test.chart" . }}
{{ include "devops-test.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "devops-test.selectorLabels" -}}
app.kubernetes.io/name: devops-test
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

