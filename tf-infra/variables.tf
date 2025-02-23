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
  type        = list(string)
  description = "Availability Zones for subnets"
}

variable "key_name" {
  description = "Name of the EC2 key pair"
  type        = string
}

variable "app_port" {
  description = "Port number of the application"
  type        = number
  default     = 8080
}

variable "custom_ami_id" {
  description = "Custom AMI ID for EC2 instance"
  type        = string
}