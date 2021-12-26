resource "aws_s3_bucket" "lb_logs" {
  bucket = "${var.project_name}_logs"
  acl    = "private"

  versioning {
    enabled = true
  }
}