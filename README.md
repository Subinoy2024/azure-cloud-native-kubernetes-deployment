# azure-cloud-native-kubernetes-deployment
# AKS Deployment Project

This project sets up a fully automated Kubernetes deployment pipeline with Azure DevOps, Terraform, and AKS.

## Setup Steps
1. Clone this repo.
2. Run `terraform init` and `terraform apply` in `infra/`.
3. Set up Azure DevOps pipelines and PR approvals.
4. Deploy via pipelines.

## Testing
- Push code to trigger CI/CD.
- Monitor via Azure Portal.