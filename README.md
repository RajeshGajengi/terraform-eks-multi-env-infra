# Designed and implemented modular Terraform infrastructure for AWS EKS Kubernetes clusters across multiple environments (dev, staging, prod).

This Terraform project provisions a complete Amazon EKS cluster on AWS using modular infrastructure. It includes a custom VPC, subnets, EKS cluster, and managed node groups. The project is environment-aware (e.g., dev, prod).

## 📌 Overview

This project automates the provisioning of a fully functional **Kubernetes cluster on AWS Elastic Kubernetes Service (EKS)** using **Terraform** with a **modular and reusable architecture**. It supports isolated **development**, **staging**, and **production** environments through parameterized configurations.



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

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/terraform-eks-multi-env-infra.git
cd terraform-eks-multi-env-infra/environments/dev
```

### 2. Configure Variables
Edit the terraform.tfvars file inside your environment (dev, staging, prod) to set your:
- AWS region
- VPC CIDR block
- Subnet configurations
- Cluster and node settings

### 3. Initialize Terraform
```bash 
terraform init
```

### 4. Plan Infrastructure
```bash
terraform plan
```

### 5. Apply Changes
```bash
terraform apply
```

## 🔐 Remote State
To enable remote state management and team collaboration, configure the backend.tf file in each environment with:

```hcl
terraform {
  backend "s3" {
    bucket         = "your-terraform-state-bucket"
    key            = "eks/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-table"
  }
}
```

## 📤 Outputs
After terraform apply, outputs will include:
- VPC ID
- Subnet IDs
- Internet/NAT Gateway IDs
- EKS Cluster Name
- Node Group Name


## 🛠 Modules Overview
### VPC Module
- Creates VPC
- Tags with environment info

### Subnets Module
- Public and private subnets
- Internet gateway & NAT gateway
- Route tables and associations

### EKS Cluster Module
- EKS control plane
- IAM role with EKS permissions

### EKS Nodes Module
- Managed node group
- Auto-scaling configuration
- IAM role for worker nodes

## 🧪 Example Terraform Variable (dev/terraform.tfvars)
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

cluster_name     = "myclust"
node_group_name  = "mynode"
desired_size     = 1
min_size         = 1
max_size         = 1

```
## 📸 Screenshots 


## Lessons Learned
- Importance of module reusability and input validation
- Managing infrastructure across multiple isolated environments
- Working with AWS IAM roles for secure cluster and node access
- Networking setup (NAT, IGW, public/private routing)

## 📌 Future Improvements
- Integrate with CI/CD (e.g., GitHub Actions or Jenkins)
- Add monitoring using Prometheus + Grafana or CloudWatch
- Configure ALB Ingress Controller and ExternalDNS
- Add Helm/ArgoCD deployment pipeline
- Write unit tests with terraform-compliance or terratest


🙋‍♂️ Author
Rajesh Gajengi