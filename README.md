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

## ## Reference Application

This project uses the course Remix Weather Application as the application base:

- Professor reference repository: [`rlmckenney/cst8918-a03-h03-pulumi-weather`](rlmckenney/cst8918-a03-h03-pulumi-weather)

The original reference project includes the application source code and Dockerfile. For this final project, the Pulumi-based infrastructure is replaced with Terraform modules, Azure AKS, Azure Redis, and GitHub Actions workflows.

---

## Project Architecture

The infrastructure is organized into Terraform modules:

- **Backend Module**
  - Azure Blob Storage for Terraform state
- **Networking Module**
  - Virtual Network: 10.0.0.0/14
  - Subnets:
    - `prod`: 10.0.0.0/16
    - `test`: 10.1.0.0/16
    - `dev`: 10.2.0.0/16
    - `admin`: 10.3.0.0/16
- **AKS Module**
  - Test cluster (1 node, B2s)
  - Production cluster (1–3 nodes, B2s)
- **Application Module**
  - Azure Container Registry (ACR)
  - AKS deployments
  - Azure Cache for Redis
  - Kubernetes services

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

3. Initialize Terraform:

```
terraform init
```

4. Validate configuration:

```
terraform validate
```

5. Apply infrastructure:

```
terraform apply
```

---

## Testing

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
terraform destroy
```

---

## Repository Link

GitHub Repository:

https://github.com/shap0011/cst8918-final-project-group-3
