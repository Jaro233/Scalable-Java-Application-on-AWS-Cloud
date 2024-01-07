variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "subnet_ids" {
  description = "List of subnet IDs for the RDS instance"
  type        = list(string)
}

variable "db_instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
}

variable "db_username" {
  description = "Username for the RDS database"
  type        = string
}

variable "db_password" {
  description = "Password for the RDS database"
  type        = string
  sensitive   = true
}

variable "vpc_id" {
  description = "The VPC ID where the RDS instance is to be provisioned"
  type        = string
}

variable "allowed_cidr_blocks" {
  description = "List of CIDR blocks that are allowed to access the RDS instance"
  type        = list(string)
}
