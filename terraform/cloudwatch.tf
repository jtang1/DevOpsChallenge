resource "aws_cloudwatch_log_group" "devopschallenge" {
  name              = "ecs/devopschallenge"
  retention_in_days = 0
}