resource "aws_ecs_cluster" "devopschallenge" {
  name = var.project_name
}

# resource "aws_ecs_task_definition" "powered_testing" {
#   family             = "powered_testing"
#   execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
#   task_role_arn      = aws_iam_role.ecs_task_execution_role.arn

#   container_definitions = <<CONTAINER
# [
#   {
#     "name": "powered_testing",
#     "image": "${aws_ecr_repository.powered_testing_repo.repository_url}:latest",
#     "cpu": 1024,
#     "memory": 2048,
#     "entrypoint": ["/Run.sh"],
#     "essential": true,
#     "environment": [
#       {
#         "name": "VPC_CIDR",
#         "value": "${var.vpc_cidr_range}"
#       }
#     ],
#     "portMappings": [
#       {
#         "containerPort": 80,
#         "hostPort": 80,
#         "protocol": "tcp"
#       }
#     ],
#     "secrets": [
#         {
#           "name": "githubUser",
#           "valueFrom": "arn:aws:secretsmanager:eu-west-1:${var.account_id}:secret:githubToken-Qcjdzi:Username::"
#         },
#         {
#           "name": "githubToken",
#           "valueFrom": "arn:aws:secretsmanager:eu-west-1:${var.account_id}:secret:githubToken-Qcjdzi:Token::"
#         }
#     ],
#     "logConfiguration": {
#       "logDriver": "awslogs",
#       "options": {
#         "awslogs-region": "${var.region}",
#         "awslogs-group": "/ecs/powered_testing",
#         "awslogs-stream-prefix": "powered_testing",
#         "awslogs-create-group": "true"
#       }
#     }
#   }
# ]
# CONTAINER


#   network_mode             = "awsvpc"
#   cpu                      = "1024"
#   memory                   = "2048"
#   requires_compatibilities = ["FARGATE"]
# }