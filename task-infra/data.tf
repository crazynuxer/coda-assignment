data "aws_caller_identity" "current" {}

data "aws_acm_certificate" "issued" {
  domain   = var.domain
  statuses = ["ISSUED"]
}


data "aws_route53_zone" "domain_zone" {
  name         = var.domain
  private_zone = false
}

data "aws_availability_zones" "all" {
  state = "available"
}

data "aws_ssm_parameter" "html_file_key" {
  name = var.ssm_parameter_path
}
