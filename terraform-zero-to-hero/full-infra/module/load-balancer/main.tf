resource "aws_lb" "this" {
  name               = var.name
  load_balancer_type = "application"
  subnets            = var.subnets
  security_groups    = [var.sg_id]
}