provider "aws" {
  region = "ap-southeast-1"
  version = "= 2.32"
}

module "elasticsearch" {
  source                  = "git::https://github.com/cloudposse/terraform-aws-elasticsearch.git?ref=master"
  namespace               = "eg"
  stage                   = "dev"
  name                    = "es"
  vpc_id                  = var.vpc
  subnet_ids              = [var.subnet]
  zone_awareness_enabled  = "false"
  elasticsearch_version   = "6.5"
  instance_type           = "m3.medium.elasticsearch"
  instance_count          = 1
  encrypt_at_rest_enabled = "false"
}