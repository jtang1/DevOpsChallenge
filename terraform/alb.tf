resource "aws_lb" "ecs" {
  name               = "${var.project_name}-alb-ecs"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.load_balancer.id]
  subnets            = module.vpc.public_subnets

  enable_deletion_protection = true

  #   access_logs {
  #     bucket  = aws_s3_bucket.b.bucket
  #     prefix  = "${var.project_name}-lb"
  #     enabled = true
  #   }
}

resource "aws_lb_target_group" "ecs" {
  name        = "${var.project_name}-ecs"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = module.vpc.vpc_id
  target_type = "ip"

  health_check {
    enabled             = true
    interval            = 300
    path                = "/"
    timeout             = 60
    matcher             = "200"
    healthy_threshold   = 5
    unhealthy_threshold = 5
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.ecs.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs.arn
  }
}