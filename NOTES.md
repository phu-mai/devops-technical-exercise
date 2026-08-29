docker build -t devops-test .

k3d cluster create --config k3d.yaml

k3d image import devops-test:latest

### Deploy
```
k create ns app
k create ns monitoring
cd terraform
terraform init
terraform plan --var-file=prod.tfvars -out=plan
```
