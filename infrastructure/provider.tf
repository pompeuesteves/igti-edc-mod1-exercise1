provider "aws" {
  region = var.aws_region
}


# Centralizar o arquivo de controle de estado do terraform
terraform {
  backend "s3" {
    bucket = "tf-state-igti-713051429766"
    key    = "state/igti/edc/mod1/terraform-mod1-exe1.tfstate"
    region = "us-east-2"
  }
}