resource "aws_route53_record" "this" {
  zone_id = var.zone_id
  name    = var.name
  type    = "A"

  alias {
    name                   = var.lb_dns
    zone_id                = var.lb_zone_id
    evaluate_target_health = true
  }
}