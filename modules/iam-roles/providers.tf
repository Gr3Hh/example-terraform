terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.23.1"
      configuration_aliases = [
        aws.first,
        aws.second
      ]
    }
  }
}