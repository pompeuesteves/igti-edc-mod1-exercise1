resource "aws_s3_bucket" "dl" {
  bucket = "datalake-igti-edc-${var.account}-tf"
  force_destroy = true
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

resource "aws_s3_bucket_ownership_controls" "dl" {
  bucket = aws_s3_bucket.dl.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "dl" {
  depends_on = [aws_s3_bucket_ownership_controls.dl]
  bucket     = aws_s3_bucket.dl.id
  acl        = "private"
}

resource "aws_s3_bucket" "aws_glue_assets" {
  bucket = "aws-glue-igti-${var.account}-${var.aws_region}"
  force_destroy = true
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

resource "aws_s3_bucket_ownership_controls" "aws_glue_assets" {
  bucket = aws_s3_bucket.aws_glue_assets.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "aws_glue_assets" {
  depends_on = [aws_s3_bucket_ownership_controls.aws_glue_assets]
  bucket = aws_s3_bucket.aws_glue_assets.id
  acl    = "private"
}

