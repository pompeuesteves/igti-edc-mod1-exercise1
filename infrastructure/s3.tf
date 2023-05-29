resource "aws_s3_bucket" "dl" {
  bucket = "datalake-igti-edc-${var.account}-tf"
  tags   = var.tags
}

resource "aws_s3_bucket_server_side_encryption_configuration" "dl" {
  bucket = aws_s3_bucket.dl.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_acl" "dl" {
  bucket = aws_s3_bucket.dl.id
  acl    = "private"
}

resource "aws_s3_bucket" "aws_glue_assets" {
  bucket = "aws-glue-igti-${var.account}-${var.aws_region}"
  tags   = var.tags
}

resource "aws_s3_bucket_server_side_encryption_configuration" "aws_glue_assets" {
  bucket = aws_s3_bucket.aws_glue_assets.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_acl" "aws_glue_assets" {
  bucket = aws_s3_bucket.aws_glue_assets.id
  acl    = "private"
}