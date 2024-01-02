terraform {
  required_version = ">= 1.4.0"
  required_providers {
    archive = {
      source = "hashicorp/archive"
    }
    aws = {
      source = "hashicorp/aws"
    }
    null = {
      source = "hashicorp/null"
    }
  }
  backend "s3" {
    bucket  = "ducket-dev-tfstate"
    key     = "ducket-dev.tfstate"
    region  = "eu-west-1"
    encrypt = "true"
  }
}