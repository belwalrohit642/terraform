terraform {
  required_version = ">=0.12"
  backend "s3" {
    bucket         = "ninjas3bucket"
    key            = "myapp/state.tfstate"
    region         = "us-east-1"
    dynamodb_table = "dynamodb-state-locking"
  }
}
provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "ninja-vpc-01" {

  cidr_block           = var.cidr_block
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "ninja-vpc-01"
    type = "custom"
  }
}

module "my_subnets" {
  source                     = "../subnets"
  vpc_id                     = aws_vpc.ninja-vpc-01.id
  public_subnet_cidr_blocks  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidr_blocks = ["10.0.3.0/24", "10.0.4.0/24"]
  avail_zone                 = ["us-east-1a", "us-east-1b"]
  env_prefix                 = var.env_prefix
}

module "my_igw" {
  source = "../igw"

  vpc_id     = aws_vpc.ninja-vpc-01.id
  env_prefix = var.env_prefix

}


module "my_routetable" {
  source = "../routetable"

  vpc_id             = aws_vpc.ninja-vpc-01.id
  public_subnet_ids  = module.my_subnets.public_subnet_ids
  private_subnet_ids = module.my_subnets.private_subnet_ids

  # private_subnet_cidr_blocks = module.my_subnets.private_subnets
  env_prefix          = var.env_prefix
  my_internet_gateway = module.my_igw.my_internet_gateway




}

module "instances" {

  source             = "../ec2"
  public_subnet_ids  = module.my_subnets.public_subnet_ids
  private_subnet_ids = module.my_subnets.private_subnet_ids
  ami_id             = var.ami_id
  instance_type      = var.instance_type
  public_keylocation = var.public_keylocation
  security_groups    = module.security_groups-dev.sg-dev

}

module "security_groups-dev" {
  source     = "../sg"
  vpc_id     = aws_vpc.ninja-vpc-01.id
  env_prefix = var.env_prefix
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.ninja-vpc-01.id
}

output "my_public_subnet_ids" {
  value = module.my_subnets.public_subnet_ids
}

output "my_private_subnet_ids" {
  value = module.my_subnets.private_subnet_ids
}
output "my_internet_gateway" {
  value = module.my_igw.my_internet_gateway
}

output "pub-instance-ip" {
  value = module.instances.public_instance-ip
}
output "priv-instance-ip" {
  value = module.instances.private_instance_ip
}
output "my-security_groups" {
  value = module.security_groups-dev.sg-dev
}
