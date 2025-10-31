# variables.tf
# This file defines all input variables for the Redis Enterprise infrastructure

variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "ap-south-1"
}

variable "key_name" {
  description = "Name of the existing EC2 key pair for SSH access"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "List of availability zones for subnet distribution"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "instance_type" {
  description = "EC2 instance type for Redis nodes"
  type        = string
  default     = "t3.medium"
}

variable "instance_count" {
  description = "Number of Redis Enterprise nodes"
  type        = number
  default     = 3
}

variable "project_name" {
  description = "Project name for resource tagging"
  type        = string
  default     = "redis-enterprise"
}

variable "ubuntu_ami_owner" {
  description = "AWS account ID of Canonical (Ubuntu publisher)"
  type        = string
  default     = "099720109477"
}
