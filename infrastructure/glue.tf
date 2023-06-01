#tfsec:ignore:aws-cloudwatch-log-group-customer-key
resource "aws_cloudwatch_log_group" "this" {
  name              = "log_group_aws_glue_igti"
  tags              = var.tags
  retention_in_days = 3
}

resource "aws_glue_job" "enem" {
  name                   = "microdados_enem_2020_exe1"
  tags                   = var.tags
  description            = "Glue Job from terraform:  microdados_enem_2020_exe1"
  role_arn               = aws_iam_role.glue.arn
  glue_version           = "3.0"
  worker_type            = "G.1X"
  number_of_workers      = 2
  max_retries            = 0
  timeout                = 30

  command {
    script_location = "s3://aws-glue-igti-${var.account}-${var.aws_region}/scripts/microdados_enem_2020_exe1.py"
    python_version  = "3"
  }

  execution_property {
    max_concurrent_runs = 1
  }

  default_arguments = {
    "--job-language"                     = "python"
    "--job-bookmark-option"              = "job-bookmark-enable"
    "--enable-metrics"                   = ""
    "--enable-continuous-cloudwatch-log" = "true"
    "--enable-spark-ui"                  = "true"
    "--spark-event-logs-path"            = "s3://aws-glue-igti-${var.account}-${var.aws_region}/sparkHistoryLogs/"
    "--TempDir"                          = "s3://aws-glue-igti-${var.account}-${var.aws_region}/temporary/"
    "--enable-glue-datacatalog"          = ""
    "--enable-continuous-log-filter"     = "true"
    "--continuous-log-logGroup"          = aws_cloudwatch_log_group.this.name
    "--class"                            = "GlueApp"
  }
}


resource "aws_glue_catalog_database" "datalake" {
  name        = "datalake-igti"
  description = "Datalake for igti projects"
  tags        = var.tags
}


resource "aws_glue_crawler" "enem" {
  database_name = aws_glue_catalog_database.datalake.name
  name          = "microdados_enem_2020"
  role          = aws_iam_role.glue.arn
  description   = "microdados_enem_2020 (exercício 1 módulo 1)"
  tags          = var.tags
  table_prefix  = "enem2020-"

  s3_target {
    path = "s3://datalake-igti-edc-${var.account}-tf/enem/"
  }
}