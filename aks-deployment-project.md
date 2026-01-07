azure-cloud-native-kubernetes-deployment/
├── infra/
│   ├── main.tf          # Calls modules (no resource definitions here)
│   ├── variables.tf     # Global variables
│   ├── outputs.tf       # Global outputs
│   └── modules/
│       ├── remote-state/
│       │   ├── main.tf
│       │   ├── variables.tf
│       │   └── outputs.tf
│       ├── key-vault/
│       │   ├── main.tf
│       │   ├── variables.tf
│       │   └── outputs.tf
│       ├── acr/
│       │   ├── main.tf
│       │   ├── variables.tf
│       │   └── outputs.tf
│       └── aks/
│           ├── main.tf
│           ├── variables.tf
│           └── outputs.tf
├── k8s/
│   ├── base/
│   │   ├── deployment.yaml
│   │   └── service.yaml
│   └── overlays/
│       └── prod/
│           ├── kustomization.yaml
│           └── patch.yaml
├── pipelines/
│   ├── ci-pipeline.yml
│   └── cd-pipeline.yml
├── src/
│   ├── Dockerfile
│   └── app.js
└── README.md