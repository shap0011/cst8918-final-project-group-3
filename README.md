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

- Terraform validation and planning
- Infrastructure deployment
- Application build and deployment

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

- **AKS Module** (`terraform/modules/aks/`)
  - Test cluster (1 node, Standard_B2s, Kubernetes 1.32)
  - Production cluster (autoscaling 1–3 nodes, Standard_B2s, Kubernetes 1.32)

- **Application Module** (`terraform/modules/app/`)
  - Azure Container Registry (ACR)
  - Azure Cache for Redis
  - (Kubernetes deployment and services to be implemented)

---

## Current Progress

- Terraform backend module created and deployed (Azure Blob Storage, canadacentral)
- Remote state configured for dev, test, and prod environments
- Base network infrastructure implemented (VNet + 4 subnets)
- AKS module created
- Test environment AKS cluster configured
- Production environment AKS cluster configured with autoscaling
- Application module implemented (ACR + Redis)
- Test environment extended with application resources (ACR + Redis)

---

## Environments

The project uses separate environments, each with its own remote Terraform state:

- **backend** – bootstraps the Azure Blob Storage for remote state (applied once manually)
- **dev** – initial infrastructure testing
- **test** – application testing and validation
- **prod** – production deployment with autoscaling

---

## Team Workflow

To maintain consistent infrastructure and avoid duplicate deployments:

- A single team member manages Azure resource deployment (`terraform apply`)
- Other team members use `terraform plan` for validation
- All changes are made through feature branches
- Pull Requests require at least one reviewer before merging

---

## CI/CD Workflows (GitHub Actions)

The project uses GitHub Actions for automation:

- On Push (any branch):
  - Terraform fmt, validate, tfsec
- **On Pull Request (main branch)**:
  - Terraform plan
  - tflint
  - Build & deploy app to **test environment**
- **On Merge to Main**:
  - Terraform apply (infrastructure deployment)
  - Deploy app to **production environment**

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
```

3. Bootstrap the Terraform backend (run once, by one team member):

```
cd terraform/backend
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

---

## Testing & Validation

Infrastructure tests are automated using GitHub Actions:

- Static analysis (fmt, validate, tfsec)
- Terraform plan validation on pull requests

---

## Screenshots

Add screenshots of successful GitHub Actions workflows here

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
