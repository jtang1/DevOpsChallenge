resource "aws_ecs_cluster" "devops_challenge" {
  name = var.project_name
}

resource "aws_ecs_task_definition" "devops_challenge" {
  family = var.project_name
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  requires_compatibilities = ["FARGATE"]

  container_definitions = <<TASK_DEFINITION
[
    {
      "name": "devops_challenge",
      "image": "${var.account_id}.dkr.ecr.${var.region}.amazonaws.com/${var.project_name}:latest",
      "cpu": 256,
      "memory": 512,
      "essential": true,
      "portMappings": [
        {
          "containerPort": 80,
          "hostPort": 80
        }
      ],
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-region": "${var.region}",
          "awslogs-group": "/ecs/${var.project_name}",
          "awslogs-stream-prefix": "${var.project_name}"
        } 
      }
    }
]
TASK_DEFINITION
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