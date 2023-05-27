resource "aws_s3_bucket" "dl" {
  bucket = "datalake-igti-edc-${var.account}-tf"
  tags   = var.tags
}

resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.dl.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.dl.id
  acl    = "private"
}