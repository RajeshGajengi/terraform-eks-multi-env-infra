environment = "dev"

# VPC and Subnets Variables
vpc_cidr_block = "123.10.0.0/16"

public_subnets = {
  public1 = { cidr = "123.10.1.0/24", az = "us-east-1a" }
  public2 = { cidr = "123.10.2.0/24", az = "us-east-1b" }
}

private_subnets = {
  priv1 = { cidr = "123.10.3.0/24", az = "us-east-1a" }
  priv2 = { cidr = "123.10.4.0/24", az = "us-east-1b" }
}

# Cluster and Node Group Variables
region         = "us-east-1"
cluster_name   = "myclust"
node_group_name = "mynode"

# Scaling Configuration for Node Group
desired_size   = 1
max_size       = 1
min_size       = 1
