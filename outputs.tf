# VPC
output "vpc_id" {
  description = "The ID of the VPC."
  value       = module.networking.vpc_id
}

# CIDR blocks
output "vpc_cidr_block" {
  description = "The CIDR block of the VPC."
  value       = module.networking.vpc_cidr_block
}

# Subnets
output "private_subnets" {
  description = "List of IDs of private subnets."
  value       = module.networking.private_subnets
}

output "public_subnets" {
  description = "List of IDs of public subnets."
  value       = module.networking.public_subnets
}

# NAT gateways
output "nat_public_ips" {
  description = "List of public Elastic IPs created for AWS NAT Gateway."
  value       = module.networking.nat_public_ips
}

# AZs
output "azs" {
  description = "A list of availability zones spefified as argument to this module."
  value       = module.networking.azs
}