provider "aws" {
  region = var.aws_region
}


# Centralizar o arquivo de controle de estado do terraform
terraform {
  backend "s3" {
    bucket = "tf-state-igti-"
    key    = "state/igti/edc/mod1/exe1/terraform.tfstate"
    region = var.aws_region
  }
}