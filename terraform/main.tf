provider "helm" {
  kubernetes = {
    config_path = "~/.kube/config"
  }
}

resource "helm_release" "devops-test" {
  name       = "devops-test"

  repository = "../helm"
  chart      = "devops-test"
  namespace = "app"

  set = [
    {
    name  = "greetingName"
    value = var.greeting_name
    }
  ]
}

resource "helm_release" "prometheus" {
  name       = "prometheus"

  repository = "oci://ghcr.io/prometheus-community/charts"
  chart      = "prometheus"
  namespace = "monitoring"

  values = [
    <<-EOT
    extraScrapeConfigs: |
      - job_name: app-job
        scrape_interval: 30s
        scrape_timeout: 5s
        metrics_path: /metrics
        scheme: http
        static_configs:
        - targets: ['devops-test.app:8080']

    serverFiles:
      alerting_rules.yml:
        groups:
          - name: greeter_alerts
            rules:
              - alert: GreeterHighErrorRate
                expr: |
                  sum(rate(greeter_http_requests_total{status=~"5.."}[5m]))
                  /
                  sum(rate(greeter_http_requests_total[5m])) > 0.05
                for: 2m
                labels:
                  severity: critical
                annotations:
                  summary: "High 5xx error rate on Greeter service"
                  description: "The 5xx error rate for the greeter service is above 5% over the last 5 minutes. Current rate: {{ $value | humanizePercentage }}"
    EOT
  ]
}
