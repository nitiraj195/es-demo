provider "aws" {
  region = "us-east-1"
}

terraform {
  required_providers {
    ansible = {
      source = "nbering/ansible"
      version = "~> 1.0"
    }
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
