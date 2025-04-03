data "aws_route53_zone" "primary" {
  name         = var.domain
  private_zone = false
}

resource "aws_route53_record" "app" {
  zone_id = data.aws_route53_zone.primary.zone_id
  name    = ""
  type    = "A"

  alias {
    name                   = aws_lb.application_alb.dns_name
    zone_id                = aws_lb.application_alb.zone_id
    evaluate_target_health = true
  }
}