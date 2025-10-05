# Designed and implemented modular Terraform infrastructure for AWS EKS Kubernetes clusters across multiple environments (dev, staging, prod).

This Terraform project provisions a complete Amazon EKS cluster on AWS using modular infrastructure. It includes a custom VPC, subnets, EKS cluster, and managed node groups. The project is environment-aware (e.g., dev, prod).


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

## 🚀 Getting Started

### 1. Prerequisites

- Terraform >= 1.3
- AWS CLI configured with appropriate IAM permissions
- An S3 bucket and DynamoDB table for remote state

### 2. Initialize Terraform

```bash
cd environments/dev
terraform init
```

### 3. Plan and Apply
```bash 
terraform plan -var-file="terraform.tfvars" 
terraform apply -var-file="terraform.tfvars"
```

## ⚙️ Modules

### vpc
#### Creates:
- Custom VPC
- Public subnets
- Route tables
#### Inputs:
- vpc_cidr
- public_subnet_cidrs
- azs

#### Outputs:
- vpc_id
- public_subnet_ids
- eks

#### Creates:
- EKS Cluster
- Managed Node Group

#### Inputs:
- cluster_name
- vpc_id
- subnet_ids
- instance_types
#### Outputs:
- cluster_name

## 🌍 Environments

Each environment (e.g., dev, prod) has:
- Its own backend config (backend.tf)
- Its own variable values (terraform.tfvars)

To deploy:
```bash
cd environments/dev
terraform apply -var-file="terraform.tfvars"
```

## 🔐 Remote State

We use an S3 bucket and DynamoDB table for:

- Storing Terraform state
- Locking to prevent concurrent changes

Configure your backend in `backend.tf`.


## 🧑‍💻 IAM Requirements

Ensure your AWS user has permissions for:
- EKS
- VPC
- IAM (if creating roles)
- EC2 (for workers and networking)

## 📌 Useful Commands
```bash
terraform fmt          # Format code
terraform validate     # Validate configuration
terraform plan         # Preview changes
terraform apply        # Apply changes
terraform destroy      # Tear down resources
```

## 🐛 Troubleshooting

- Access Denied: Check IAM role permissions.
- Timeouts: Ensure your NAT Gateway and route tables are configured properly.
- kubectl not working: Run:
```bash
aws eks update-kubeconfig --region us-east-1 --name dev-eks
```