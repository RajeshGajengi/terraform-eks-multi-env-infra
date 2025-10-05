variable "instance_type" {
  type = string
  description = "Instance type"
}

variable "env" {
  type = string
  description = "Environments (dev/stage/prod)"
 
}


# VPC and SUbnets Variables

variable "region" {
  
}

variable "vpc_cidr_block" {
}

variable "public_subnets" {
  description = "Map of public subnet CIDRs with AZs"
  type = map(object({
    cidr = string
    az   = string
  }))
}

variable "private_subnets" {
  description = "Map of private subnet CIDRs with AZs"
  type = map(object({
    cidr = string
    az   = string
  }))

}


# Cluster and Nodes
variable "cluster_name" {
  description = "Name of cluster"
}

variable "node_group_name" {
  description = "Node group name"
}

variable "desired_size" {
  
}

variable "max_size" {
  
}

variable "min_size" {
  
}