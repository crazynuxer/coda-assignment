variable "name" {
  default     = "test-iam-role"
  description = "Role name."
  type        = string
}

variable "account" {
  default     = "arn:aws:iam::1234567890:root"
  description = "Account user ARN."
  type        = string
}
