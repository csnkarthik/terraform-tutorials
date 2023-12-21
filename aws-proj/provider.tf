terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.31.0"
    }
  }
}

provider "aws" {
  region     = "us-west-2"
  access_key = "AKIATHWEAKG4EU7LHGNL"
  secret_key = "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"
}