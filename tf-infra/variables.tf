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

variable "s3_bucket_name" {
  description = "Name of S3 bucket"
  type        = string
}

variable "my_ip_cidr" {
  description = "My IP Address with CIDR"
  type        = string
}

variable "database_engine" {
  description = "Database Engine"
  type        = string
}

variable "instance_class" {
  description = "Instance Class"
  type        = string
}

variable "db_instance_identifier" {
  description = "Database Instance Identifier"
  type        = string
}

variable "db_username" {
  description = "Database Username"
  type        = string
}

variable "db_password" {
  description = "Database Password"
  type        = string
}

variable "db_name" {
  description = "Database Name"
  type        = string
}

variable "db_engine_version" {
  description = "Database Engine Version"
  type        = string
}

variable "domain" {
  description = "Domain"
  type        = string
}