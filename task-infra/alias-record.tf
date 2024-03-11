resource "aws_route53_record" "coda_alias" {
  zone_id = data.aws_route53_zone.domain_zone.zone_id # or your hosted zone ID as a variable/string
  name    = "coda.${var.domain}"
  type    = "A"

  alias {
    name                   = aws_lb.alb.dns_name # Replace with your ALB DNS name
    zone_id                = aws_lb.alb.zone_id  # Replace with your ALB hosted zone ID
    evaluate_target_health = true
  }
}
