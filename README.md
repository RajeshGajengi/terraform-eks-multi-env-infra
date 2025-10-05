# 🚀 Terraform AWS EKS Multi-Environment Infrastructure

> **Designed and implemented modular Terraform infrastructure for AWS EKS Kubernetes clusters across multiple environments (dev, staging, prod).**

This project provisions a complete **Amazon EKS (Elastic Kubernetes Service)** infrastructure on **AWS** using **modular Terraform code**. It includes a custom **VPC**, public/private subnets, **EKS cluster**, and **managed node groups**. Each environment (e.g., dev, staging, prod) is isolated with its own configuration and backend.



## 🧱 Features

- ✅ Modular Terraform codebase (VPC, Subnets, EKS Cluster, Node Groups)
- ✅ Multi-environment support (`dev`, `staging`, `prod`)
- ✅ Automated provisioning of:
  - Custom VPC with public/private subnets
  - Internet Gateway & NAT Gateway
  - EKS cluster with managed node groups
- ✅ IAM roles and policies for EKS and EC2
- ✅ Remote state configuration ready (e.g., S3 + DynamoDB)
- ✅ Easily extendable for CI/CD and monitoring



## 📁 Project Structure

```
terraform-eks/
├── modules/
│   ├── eks-cluster
│   ├── vpc
│   ├── subnets
│   └── node-group
├── environments/
│   ├── dev/
|   |   ├── backend.tf
|   |   ├── main.tf
|   |   ├── variables.tf
|   |   └── outputs.tf
│   ├── staging/
|   |   ├── backend.tf
|   |   ├── main.tf
|   |   ├── variables.tf
|   |   └── outputs.tf
│   └── prod/
|   |   ├── backend.tf
|   |   ├── main.tf
|   |   ├── variables.tf
|   └── outputs.tf
└── Readme.md

```
## 🚀 Tech Stack
- Terraform (IaC)
- AWS EKS (Managed Kubernetes)
- AWS VPC, EC2, IAM, Subnet, NAT, IGW
- Kubernetes
- S3 & DynamoDB for remote state


Each environment contains:
- `backend.tf` — Remote state backend config (S3 + DynamoDB)
- `main.tf` — Module invocations
- `variables.tf` — Variable declarations
- `outputs.tf` — Output values
- `terraform.tfvars` — Environment-specific values


## 🧱 Infrastructure Components

### 🔹 VPC Module
Creates a custom VPC with:
- Public and private subnets
- Internet Gateway and NAT Gateway
- Route tables and associations

**Inputs:**
- `vpc_cidr_block`
- `public_subnets`
- `private_subnets`
- `env`

**Outputs:**
- `vpc_id`
- `subnet_ids`
- `gateway_ids`


### 🔹 Subnets Module
Creates:
- Public subnets with auto-assign public IPs
- Private subnets with NAT access
- Routing configuration for both


### 🔹 EKS Cluster Module
Creates:
- Amazon EKS Control Plane
- IAM role for the EKS service

**Inputs:**
- `cluster_name`
- `vpc_id`
- `env`

**Outputs:**
- `cluster_name`


### 🔹 EKS Nodes Module
Creates:
- Managed node groups (worker nodes)
- IAM roles and policy attachments
- Auto-scaling config (desired, min, max size)

**Inputs:**
- `cluster_name`
- `node_group_name`
- `desired_size`, `min_size`, `max_size`
- `vpc_id`
- `env`

**Outputs:**
- `node_group_name`


## 🌍 Environments

Supports isolated environments:  
- `dev/`
- `staging/`
- `prod/`

Each environment has its own:
- Variable values in `terraform.tfvars`
- Backend configuration
- Resource naming using `env` prefix

Example:
```hcl
env = "dev"
region = "us-east-1"
cluster_name = "dev-eks"
```

## ⚙️ Getting Started

### 1️⃣ Prerequisites
- Terraform >= 1.3
- AWS CLI
- AWS IAM user/role with permissions for:
    - EKS
    - VPC
    - EC2
    - IAM

### 2️⃣ Configure Backend

Edit the backend.tf file in each environment:
```hcl
terraform {
  backend "s3" {
    bucket         = "your-tf-state-bucket"
    key            = "eks/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "your-tf-lock-table"
  }
}

```
### 3️⃣ Deploy an Environment
```hcl
cd environments/dev

terraform init

terraform plan -var-file="terraform.tfvars"

terraform apply -var-file="terraform.tfvars"

```

## 🧑‍💻 Sample terraform.tfvars (Dev Environment)
```hcl
env = "dev"
region = "us-east-1"
vpc_cidr_block = "123.10.0.0/16"

public_subnets = {
  public1 = { cidr = "123.10.1.0/24", az = "us-east-1a" }
  public2 = { cidr = "123.10.2.0/24", az = "us-east-1b" }
}

private_subnets = {
  priv1 = { cidr = "123.10.3.0/24", az = "us-east-1a" }
  priv2 = { cidr = "123.10.4.0/24", az = "us-east-1b" }
}

cluster_name     = "dev-eks"
node_group_name  = "dev-node-group"
desired_size     = 1
min_size         = 1
max_size         = 2

```

## 📤 Outputs

After terraform apply, outputs include:
- VPC ID
- Public & private subnet IDs
- EKS cluster name
- Node group name
- Internet and NAT Gateway IDs

## 🔐 Remote State Benefits

This project uses Terraform remote state with S3 + DynamoDB:
- Shared state for teams
- Locking to prevent concurrent runs
- Safe infrastructure changes across environments

## 🧪 Useful Terraform Commands
```bash
terraform fmt         # Format Terraform files
terraform validate    # Validate syntax
terraform plan        # Preview changes
terraform apply       # Apply infrastructure
terraform destroy     # Tear down resources

```
## 🐛 Troubleshooting
| Issue                                       | Fix                                                               |
| ------------------------------------------- | ----------------------------------------------------------------- |
| `AccessDenied`                              | Check your AWS IAM user or role permissions                       |
| `Timeout` during subnet or gateway creation | Ensure proper VPC routes and NAT/IGW setup                        |
| `kubectl` not connecting                    | Run `aws eks update-kubeconfig --region us-east-1 --name dev-eks` |



##  📌 Future Enhancements
- Add GitHub Actions CI/CD pipeline for Terraform
- Add Helm charts or ArgoCD for workload deployment
- Configure Ingress Controller (ALB) and ExternalDNS
- Add Prometheus/Grafana for monitoring
- Add Terraform compliance testing

👨‍💻 Author
Rajesh Gajengi