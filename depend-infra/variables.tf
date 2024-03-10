variable "aws_region" {
  description = "The AWS region for the deployment"
  type        = string
  default     = "ap-southeast-1"
}

variable "s3_bucket_html" {
  description = "Name of the S3 bucket for HTML files"
  type        = string
}

variable "ssm_parameter_path" {
  description = "ssm parameter store path"
  type        = string
}

variable "s3_codepipeline_artifact" {
  description = "Name of the S3 bucket for codepipeline artifact files"
  type        = string
}

variable "codepipeline_connection_arn" {
  description = "codestart arn for codepipeline connection"
  type        = string
}
