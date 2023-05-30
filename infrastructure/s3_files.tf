resource "aws_s3_object" "glue_job" {
  bucket = aws_s3_bucket.aws_glue_assets.id
  key    = "scripts/microdados_enem_2020_exe1.py"
  acl    = "private"
  source = "../etl/microdados_enem_2020_exe1.py"
  etag   = filemd5("../etl/microdados_enem_2020_exe1.py")
}