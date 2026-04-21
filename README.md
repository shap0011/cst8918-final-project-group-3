# CST8918 Final Project – Terraform, AKS, and GitHub Actions

## Team Members

**Olga Durham** – https://github.com/shap0011 \
**Anani Thierry Kassa** – https://github.com/AnaniKassa \
**Dolsom Bouda** – https://github.com/boud0217 \
**Junfeng Rong** – https://github.com/JunfengRong

---

## Project Overview

This project demonstrates the implementation of **Infrastructure as Code (IaC)** using Terraform to deploy and manage cloud infrastructure on Microsoft Azure.

The project provisions and manages:

- Azure Kubernetes Service (AKS) clusters
- Azure Container Registry (ACR)
- Azure Cache for Redis
- Virtual network infrastructure
- Terraform backend using Azure Blob Storage

The application deployed is the **Remix Weather Application**, which is containerized and deployed to Kubernetes clusters.

GitHub Actions is used to automate:

- Terraform static analysis and validation
- Terraform planning and deployment
- Application build, push, and deployment

---

## Reference Application

This project uses the course Remix Weather Application as the application base:

- Professor reference repository: [`rlmckenney/cst8918-a03-h03-pulumi-weather`](https://github.com/rlmckenney/cst8918-a03-h03-pulumi-weather)

The original reference project includes the application source code and Dockerfile. For this final project, the Pulumi-based infrastructure is replaced with Terraform modules, Azure AKS, Azure Redis, and GitHub Actions workflows.

---

## Project Architecture

The infrastructure is organized into Terraform modules:

- **Backend Module** (`terraform/modules/backend/`)
  - Azure Resource Group for backend storage
  - Azure Storage Account (Standard LRS, TLS 1.2)
  - Azure Blob Container (`tfstate`) for Terraform state files
  - Bootstrap environment at `terraform/environments/backend/` — applied once manually
  - Each environment (`dev`, `test`, `prod`) stores its state in a separate key:
    - `dev.terraform.tfstate`
    - `test.terraform.tfstate`
    - `prod.terraform.tfstate`

- **Networking Module** (`terraform/modules/network/`)
  - Virtual Network: 10.0.0.0/14
  - Subnets:
    - `prod`: 10.0.0.0/16
    - `test`: 10.1.0.0/16
    - `dev`: 10.2.0.0/16
    - `admin`: 10.3.0.0/16

- **ACR Module** (`terraform/modules/acr/`)
  - Single shared Azure Container Registry (Basic SKU)
  - Deployed in the test environment, shared with prod

- **AKS Module** (`terraform/modules/aks/`)
  - Test cluster (1 node, Standard_B2s, Kubernetes 1.33)
  - Production cluster (autoscaling 1–3 nodes, Standard_B2s, Kubernetes 1.33)

- **Application Module** (`terraform/modules/app/`)
  - Azure Cache for Redis (Basic C0) — one instance per environment
  - Test Redis: `group3-test-redis`
  - Prod Redis: `group3-prod-redis`

- **Kubernetes Manifests** (`k8s/`)
  - Deployment and Service for the Remix Weather Application
  - Image pulled from ACR, Redis credentials injected via Kubernetes Secret

---

## Environments

The project uses separate environments, each with its own remote Terraform state:

- **backend** – bootstraps the Azure Blob Storage for remote state (applied once manually)
- **dev** – base network infrastructure
- **test** – AKS cluster, ACR, Redis, application deployment
- **prod** – AKS cluster with autoscaling, Redis, application deployment

---

## CI/CD Workflows (GitHub Actions)

| Workflow | Trigger | Jobs |
|---|---|---|
| `static-analysis.yml` | Push to any branch (terraform changes) | terraform fmt, validate, tfsec |
| `pr-checks.yml` | Pull request to main (terraform changes) | tflint, terraform plan |
| `terraform-apply.yml` | Push to main (terraform changes) | terraform apply (test + prod) |
| `app-ci.yml` | PR or push to main (app/k8s changes) | Docker build & push to ACR, deploy to test (PR) or prod (merge) |

---

## Azure Infrastructure

- Region: `canadacentral`
- Subscription: `MOC DS - 10266`
- Backend storage: `cst8918grp3tfstate` (Azure Blob Storage)
- Container Registry: `group3acr.azurecr.io`
- Test AKS: `group3-test-aks`
- Prod AKS: `group3-prod-aks`
- Test Redis: `group3-test-redis.redis.cache.windows.net`
- Prod Redis: `group3-prod-redis.redis.cache.windows.net`

---

## How to Run the Project

### Prerequisites

- Azure account
- Terraform installed
- Docker installed
- kubectl installed
- Azure CLI installed

### Setup Steps

1. Clone the repository:

```
git clone https://github.com/shap0011/cst8918-final-project-group-3.git
cd cst8918-final-project-group-3
```

2. Login to Azure:

```
az login
az account set --subscription "efd1c19c-fd0b-4ed0-9233-72467657d647"
```

3. Bootstrap the Terraform backend (run once, by one team member):

```
cd terraform/environments/backend
terraform init
terraform apply
```

4. Initialize each environment (connects to the remote backend):

```
cd terraform/environments/dev
terraform init

cd terraform/environments/test
terraform init

cd terraform/environments/prod
terraform init
```

5. Plan and apply an environment:

```
terraform plan
terraform apply
```

6. After deploying AKS, attach ACR and create Redis secret:

```
az aks update --name group3-test-aks --resource-group cst8918-final-project-group-3-test --attach-acr group3acr

kubectl create secret generic redis-credentials \
  --from-literal=REDIS_URL="rediss://:PRIMARY_KEY@group3-test-redis.redis.cache.windows.net:6380"
```

---

## Screenshots

### All Workflows History
![All Workflows History](screenshots/all%20workflows%20history.png)

### Terraform Static Analysis
![Terraform Static Analysis](screenshots/Terroform%20static%20analysis.png)

### Terraform PR Checks
![PR Checks Workflow](screenshots/PR%20checks%20workflow.png)

### Terraform Apply
![Terraform Apply Workflow](screenshots/terraform%20apply%20workflow.png)

### Application CI/CD — Build and Push
![App CI Build and Push](screenshots/app-ci%20workflow%20build%20and%20push.png)

### Application CI/CD — Deploy
![App CI Deploy](screenshots/app-ci%20workflow%20deploy.png)

---

## Clean Up

After completing the project, remove Azure resources to avoid unnecessary charges:

```
cd terraform/environments/prod
terraform destroy

cd terraform/environments/test
terraform destroy

cd terraform/environments/dev
terraform destroy

cd terraform/environments/backend
terraform destroy
```

---

## Repository Link

GitHub Repository:

https://github.com/shap0011/cst8918-final-project-group-3

---
