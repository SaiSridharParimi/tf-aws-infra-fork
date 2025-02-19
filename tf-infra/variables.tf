variable "region" {
  type        = string
  description = "AWS Region"
}

variable "cidr_block" {
  type        = string
  description = "CIDR block"
}

variable "vpc_tag" {
  type        = string
  description = "Name of VPC"
}

variable "public_subnet_cidr" {
  type        = list(string)
  description = "CIDR blocks for public subnets"
}

variable "private_subnet_cidr" {
  type        = list(string)
  description = "CIDR blocks for private subnets"
}

variable "availability_zones" {
  type               = list(string)
  description = "Availability Zones for subnets"
}