resource "aws_lb" "test" {
  name               = "${var.project_name}-alb-ecs"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.load_balancer.id]
  subnets            = module.vpc.public_subnets

  enable_deletion_protection = true

  access_logs {
    bucket  = aws_s3_bucket.lb_logs.bucket
    prefix  = "${var.project_name}-lb"
    enabled = true
  }
}