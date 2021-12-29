resource "aws_s3_bucket" "lb_logs" {
  bucket = "${var.project_name}-lb-logs"
  acl    = "log-delivery-write"

  versioning {
    enabled = true
  }
}

data "local_file" "s3_access_log_policy" {
  filename = "files/s3_access_log_policy.json"
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.lb_logs.id
  policy = data.local_file.s3_access_log_policy.content
}

resource "aws_s3_bucket" "b" {
  bucket = "my-tf-test-bucket-devops-challenge"
  acl    = "private"
}