# resource "aws_s3_bucket" "lb_logs" {
#   bucket = "${var.project_name}-logs"
#   acl    = "log-delivery-write"

#   versioning {
#     enabled = true
#   }
# }

resource "aws_s3_bucket" "log_bucket" {
  bucket = "${var.project_name}-log-bucket"
  acl    = "log-delivery-write"
}

resource "aws_s3_bucket" "b" {
  bucket = "${var.project_name}-test-bucket"
  acl    = "private"

  logging {
    target_bucket = aws_s3_bucket.log_bucket.id
    target_prefix = "log/"
  }
}