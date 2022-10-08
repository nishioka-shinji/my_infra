# Terraform configration
terraform {
  required_version = ">=0.13"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.34"
    }
  }
}

# Provider
provider "aws" {
  profile = "terraform"
  region  = "us-east-1"
}

# Variables
variable "project" {
  type = string
}

variable "environment" {
  type = string
}