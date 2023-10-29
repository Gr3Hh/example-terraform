terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.23.1"
    }
  }

  backend "s3" {
    bucket = "test-task-tfstate-pp"
    key    = "iam"
    region = "eu-west-1"
  }
}

provider "aws" {
  region  = "eu-west-1"
  profile = "first"
}

provider "aws" {
  region  = "eu-west-1"
  alias   = "second"
  profile = "second"
}

module "iam_accounts" {
  source = "../modules/iam-accounts"

  gui_users_account = var.gui_users_account
  cli_user_accounts = var.cli_user_accounts
}

module "iam_roles" {
  source = "../modules/iam-roles"

  providers = {
    aws.first  = aws
    aws.second = aws.second
  }
}
