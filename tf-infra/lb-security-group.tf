
resource "aws_security_group" "alb_sg" {
  name        = "alb-security-group"
  description = "Allow HTTP inbound traffic to ALB"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTP from Internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP from Internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb-security-group"
  }
}

resource "aws_lb_target_group" "application_tg" {
  name        = "application-target-group"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "instance"

  health_check {
    # enabled             = true
    interval            = 60
    path                = "/healthz"
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
    matcher             = "200"
  }

  tags = {
    Name = "application-target-group"
  }
}

resource "aws_lb" "application_alb" {
  name               = "application-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets = [
    aws_subnet.main_public_subnet[0].id,
    aws_subnet.main_public_subnet[1].id,
    aws_subnet.main_public_subnet[2].id
  ]

  enable_deletion_protection = false

  tags = {
    Name = "application-alb"
  }
}

data "aws_acm_certificate" "ssl_cert" {
  domain      = "demo.sridharp.me" #dev.sridhar.me
  statuses    = ["ISSUED"]
  most_recent = true
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.application_alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = data.aws_acm_certificate.ssl_cert.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.application_tg.arn
  }
}
