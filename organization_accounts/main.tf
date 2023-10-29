terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.23.1"
    }
  }

  backend "s3" {
    bucket = "test-task-tfstate-pp"
    key    = "organization-accounts"
    region = "eu-west-1"
  }
}

provider "aws" {
  region  = "eu-west-1"
  profile = "first"
}

module "organization_accounts" {
  source = "../modules/organization_accounts"

  accounts = var.accounts
}
