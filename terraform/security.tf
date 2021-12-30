resource "aws_security_group" "load_balancer" {
  vpc_id = module.vpc.vpc_id
  tags = {
    Name = "load-balancer"
  }
}

resource "aws_security_group" "ecs_task" {
  vpc_id = module.vpc.vpc_id
  tags = {
    Name = "ecs-task"
  }
}

resource "aws_security_group_rule" "ingress_load_balancer" {
  from_port         = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.load_balancer.id
  to_port           = 80
  cidr_blocks       = ["0.0.0.0/0"]
  type              = "ingress"
}

resource "aws_security_group_rule" "ingress_ecs_task" {
  from_port                = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ecs_task.id
  to_port                  = 80
  source_security_group_id = aws_security_group.load_balancer.id
  type                     = "ingress"
}

resource "aws_security_group_rule" "egress_load_balancer" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.load_balancer.id
}

resource "aws_security_group_rule" "egress_ecs_task" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ecs_task.id
}