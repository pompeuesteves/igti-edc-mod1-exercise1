variable "aws_region" {
  default = "us-east-2"
}

variable "account" {
  default = "713051429766"
}

variable "tags" {
  type = map(any)
  default = {
    IES       = "IGTI"
    CURSO     = "EDC"
    ManagedBy = "Terraform"
  }
}

variable "name_role_glue" {
  default = "AWSGlueServiceRole-IGTI"
}

variable "name_policy_glue" {
  default = "AWSGluePolicy-DatalakeIGTI"
}