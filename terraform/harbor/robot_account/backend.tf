terraform {
  required_version = "1.13.5"
  required_providers {
    harbor = {
      source = "goharbor/harbor"
      version = "3.11.2"
    }
  }

  backend "gcs" {
    bucket = "shinji-nishioka-test-terraform-state"
    prefix = "terraform/harbor/robot_account"
  }
}

provider "harbor" {
  url      = "https://harbor.nishiokatest.xyz"
  password = var.harbor_admin_password
  username = "admin"
}

variable "harbor_admin_password" {
  type = string
}