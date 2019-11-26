provider "aws" {
  region = "ap-southeast-1"
  version = "= 2.32"
}

data "aws_security_group" "default" {
  name   = "default"
  vpc_id = module.vpc.vpc_id
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "dkatalis-vpc"

  cidr = "12.0.0.0/16"

  azs             = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
  private_subnets = ["12.0.1.0/24", "12.0.2.0/24", "12.0.3.0/24"]
  public_subnets  = ["12.0.101.0/24", "12.0.102.0/24", "12.0.103.0/24"]

  enable_ipv6 = false

  enable_nat_gateway = true
  single_nat_gateway = true

  public_subnet_tags = {
    Name = "dkatalis-subnet-public"
  }

  tags = {
    Owner       = "dkatalis"
    Environment = "dev"
  }

  vpc_tags = {
    Name = "dkatalis"
  }
}