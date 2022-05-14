provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket = "tf-state-igti-lin"
    key    = "state/igti/edc/mod1/terraform.tfstate"
    region = "us-east-2"
  }
}