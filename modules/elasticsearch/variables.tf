variable "vpc" {
  type        = string
  description = "VPC to put Elasticsearch instance."
  default     = "vpc-e8aca18f"
}

variable "subnet" {
  type        = string
  description = "Subnet to put Elasticsearch instance."
  default     = "subnet-655bbd2d"
}