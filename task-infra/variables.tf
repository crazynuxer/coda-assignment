variable "aws_region" {
  description = "The AWS region for the deployment"
  type        = string
  default     = "ap-southeast-1"
}

variable "s3_bucket_html" {
  description = "Name of the S3 bucket for HTML files"
  type        = string
}

variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}

variable "ecs_service_name" {
  description = "Name of the ECS service"
  type        = string
}

variable "alb_ssl_policy" {
  description = "SSL policy for the ALB"
  type        = string
  default     = "ELBSecurityPolicy-2016-08"
}

variable "ecs_cloudwatch_log" {
  description = "CloudWatch log group for ECS"
  type        = string
}

variable "domain" {
  description = "Domain name"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "flowlogs_s3_logging_bucket_name" {
  description = "Name of the S3 bucket for VPC Flow Logs"
  type        = string
}

variable "ssm_parameter_path" {
  description = "ssm parameter store path"
  type        = string
}

