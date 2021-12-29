resource "aws_ecs_cluster" "devops_challenge" {
  name = var.project_name
}

data "local_file" "container_task_definition" {
  filename = "files/container_def.json"
}

resource "aws_ecs_task_definition" "devops_challenge" {
  family                   = var.project_name
  container_definitions    = data.local_file.container_task_definition.content
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  requires_compatibilities = ["FARGATE"]
}

resource "aws_ecs_service" "devops_challenge" {
  name            = var.project_name
  cluster         = aws_ecs_cluster.devops_challenge.id
  task_definition = aws_ecs_task_definition.devops_challenge.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  lifecycle {
    ignore_changes = [desired_count]
  }

  network_configuration {
    subnets          = module.vpc.public_subnets
    security_groups  = [aws_security_group.ecs_task.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.ecs.arn
    container_name   = "devops_challenge"
    container_port   = 80
  }
}