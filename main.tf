terraform {
  required_version = "= 0.12.10"
  backend "s3" {
    bucket = "vwib-terraform-state"
    key    = "dkatalis.tfstate"
    region = "ap-southeast-1"
  }
}

module "networking" {
  source = "./modules/networking"
}

module "vpnserver" {
  source = "./modules/vpn"
  subnet = tostring(element(module.networking.private_subnets, 0))
  client_cidr = "116.12.0.0/16"
}

module "elasticsearch" {
  source = "./modules/elasticsearch"
  vpc =  module.networking.vpc_id
  subnet = tostring(element(module.networking.private_subnets, 0))
}