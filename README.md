# CST8918 Final Project – Terraform, AKS, and GitHub Actions

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

## Team Members

**Olga Durham** – https://github.com/shap0011 \
**Anani Thierry Kassa** – https://github.com/AnaniKassa \
**Dolsom Bouda** – https://github.com/boud0217 \
**Junfeng Rong** – https://github.com/JunfengRong

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
