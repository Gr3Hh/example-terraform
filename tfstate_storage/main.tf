terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.23.1"
    }
  }

  backend "s3" {
    bucket = "test-task-tfstate-pp"
    key    = "tfstate-storage"
    region = "eu-west-1"
  }
}

provider "aws" {
  region  = "eu-west-1"
  profile = "first"
}


module "remote_tfstate" {
  source = "../modules/bucket"

  region      = var.region
  bucket_name = var.bucket_name

  enable_versioning = var.enable_versioning
}