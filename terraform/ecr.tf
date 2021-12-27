resource "aws_ecr_repository" "devops_challenge" {
  name = var.project_name
  image_scanning_configuration {
    scan_on_push = true
  }
}