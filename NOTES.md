# Local operator notes

## kubectl vs Docker Desktop

k3d maps the API to a **random host port** (see `docker ps` on `k3d-k3s-default-serverlb`, e.g. `34787->6443`). The default `kubectl` context is often `docker-desktop`, which will refuse connections if Kubernetes Desktop is not running.

Use the k3d kubeconfig:

```powershell
# If k3d is on PATH:
k3d kubeconfig merge k3s-default --kubeconfig-switch-context

# If k3d is not on PATH, copy kubeconfig from the server container and rewrite the port:
# docker port k3d-k3s-default-serverlb 6443
$env:KUBECONFIG = "$env:USERPROFILE\.kube\k3d-k3s-default.yaml"
kubectl get nodes
```

Terraform uses `kubeconfig_path` (default `~/.kube/config`). To apply against k3d:

```powershell
cd terraform
terraform apply -var-file=prod.tfvars -var="kubeconfig_path=$env:USERPROFILE\.kube\k3d-k3s-default.yaml"
```

## Build, cluster, deploy

```
docker build -t devops-test .
k3d cluster create --config k3d.yaml
k3d image import devops-test:latest
kubectl create ns app
kubectl create ns monitoring
cd terraform
terraform init
terraform plan -var-file=prod.tfvars -out=tfplan
terraform apply tfplan
```

## Prometheus UI

Not on host port 8080 (that is the greeter Ingress). Port-forward:

```
kubectl port-forward -n monitoring svc/prometheus-server 9090:80
```

Open http://localhost:9090 — Targets (`app-job`), Alerts (`GreeterHighErrorRate`).
