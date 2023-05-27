resource "aws_s3_bucket" "dl" {
  bucket = "datalake-igti-edc-${var.account}-tf"
  acl    = "private"

  tags = var.tags

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}