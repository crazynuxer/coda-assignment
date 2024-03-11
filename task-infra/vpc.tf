# Get list of AWS Availability Zones in current region.

terraform {
  backend "s3" {
  }
}


module "staging" {
  source = "../terraform-aws-vpc/"

  product_domain = "tsi"
  environment    = var.vpc_name

  vpc_name                 = var.vpc_name
  vpc_cidr_block           = var.vpc_cidr
  vpc_enable_dns_support   = "true"
  vpc_enable_dns_hostnames = "true"
  vpc_multi_tier           = "true"

  flowlogs_s3_logging_bucket_name = var.flowlogs_s3_logging_bucket_name

  subnet_availability_zones = ["${var.aws_region}a", "${var.aws_region}b"]
}
