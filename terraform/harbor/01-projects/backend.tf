terraform {
  required_version = "1.14.0"
  required_providers {
    harbor = {
      source = "goharbor/harbor"
      version = "3.11.3"
    }
  }

  backend "gcs" {
    bucket = "shinji-nishioka-test-terraform-state"
    prefix = "terraform/harbor/01-projects"
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