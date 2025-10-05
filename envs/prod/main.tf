provider "aws" {
  region = var.region
}

module "ec2" {
  source = "../../modules/ec2"
  instance_type = var.instance_type
  env = var.env
}

module "vpc" {
  source = "../../modules/vpc"
  vpc_cidr_block = var.vpc_cidr_block
  env = var.env
}

module "subnet" {
  source = "../../modules/subnets"
  vpc_id = module.vpc.vpc_id
  env = var.env
  public_subnets = var.public_subnets
  private_subnets = var.private_subnets
}

module "eks-cluster" {
   source = "../../modules/eks-cluster"
   env = var.env
   cluster_name = var.cluster_name 
   vpc_id = module.vpc.vpc_id
}

module "eks-nodes" {
  source = "../../modules/eks-nodes"
  node_group_name = var.node_group_name
  cluster_name = module.eks-cluster.cluster_name
  vpc_id = module.vpc.vpc_id
  env = var.env
  desired_size = var.desired_size
  max_size = var.max_size
  min_size = var.min_size

}