variable "subnet" {
  type    = string
  description = "Subnet to attach VPN server to. Default to default subnet."
  default = "subnet-655bbd2d"
}

variable "client_cidr" {
  type = string
  description = "Client CIDR that can connect to the VPN server."
  default = "11.0.0.0/22"
}