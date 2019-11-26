provider "aws" {
  region = "ap-southeast-1"
  version = "= 2.32"
}

resource "aws_cloudwatch_log_group" "dkatalis" {
  name = "dkatalis-vpn"
}

resource "aws_cloudwatch_log_stream" "vpn" {
  name           = "dkatalis-vpn-stream"
  log_group_name = "${aws_cloudwatch_log_group.dkatalis.name}"
}

resource "aws_ec2_client_vpn_endpoint" "dkatalis" {
  description            = "dkatalis-clientvpn"
  server_certificate_arn = "arn:aws:acm:ap-southeast-1:797851190435:certificate/952e1b16-31c1-4a18-bb7f-5b8b78970095"
  client_cidr_block      = var.client_cidr

  authentication_options {
    type                       = "certificate-authentication"
    root_certificate_chain_arn = "arn:aws:acm:ap-southeast-1:797851190435:certificate/cd27556a-85f4-4eb8-bea2-12a0b2ec3891"
  }

  connection_log_options {
    enabled               = true
    cloudwatch_log_group  = "${aws_cloudwatch_log_group.dkatalis.name}"
    cloudwatch_log_stream = "${aws_cloudwatch_log_stream.vpn.name}"
  }

  tags = {
    Name = "dkatalis-vpn-endpoint"
  }
}

resource "aws_ec2_client_vpn_network_association" "dkatalis" {
  client_vpn_endpoint_id = "${aws_ec2_client_vpn_endpoint.dkatalis.id}"
  subnet_id              = var.subnet
}