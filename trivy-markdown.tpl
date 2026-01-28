### Trivy Docker Image Vulnerability Scan Results

{{- if . }}
| Package | ID | Severity | Installed | Fixed In |
|:---:|:---:|:---:|:---:|:---:|
{{- range . }}
{{- range .Vulnerabilities }}
| {{ .PkgName }} | {{ .VulnerabilityID }} | {{ .Severity }} | {{ .InstalledVersion }} | {{ .FixedVersion }} |
{{- end }}
{{- end }}
{{- else }}
No vulnerabilities found.
{{- end }}
