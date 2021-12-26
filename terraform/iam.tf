data "local_file" "ecs_tasks_assume_policy" {
  filename = "files/ecs_assume_role.json"
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name               = "ecsTaskExecution"
  assume_role_policy = data.local_file.ecs_tasks_assume_policy.content
}