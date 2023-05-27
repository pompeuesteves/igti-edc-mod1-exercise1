variable "aws_region" {
  default = "us-east-2"
}

variable "account" {
  default = "713051429766"
}

variable "tags" {
  type = map
  default = {
    IES      = "IGTI"
    CURSO    = "EDC"
  }
}
