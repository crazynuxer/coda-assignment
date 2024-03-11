# Get list of AWS Availability Zones in current region.
data "aws_availability_zones" "all" {
  state = "available"
}

module "staging" {
  source = "../../"

  product_domain = "tsi"
  environment    = "staging"

  vpc_name                 = "staging"
  vpc_cidr_block           = "172.27.0.0/16"
  vpc_enable_dns_support   = "true"
  vpc_enable_dns_hostnames = "true"
  vpc_multi_tier           = "true"

  flowlogs_s3_logging_bucket_name = "flowlogs-tsi-staging"

  subnet_availability_zones = data.aws_availability_zones.all.names
}

