variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnets" {
  description = "List of subnet IDs"
  type        = list(string)
}

variable "ami_id" {
  description = "AMI ID for the launch configuration"
  type        = string
}

variable "iam_role" {
  description = "iam role arn"
  type        = string
}
