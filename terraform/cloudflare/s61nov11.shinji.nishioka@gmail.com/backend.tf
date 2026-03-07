terraform {
  required_version = "1.14.6"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "7.22.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "5.18.0"
    }
  }

  backend "gcs" {
    bucket = "shinji-nishioka-test-terraform-state"
    prefix = "terraform/cloudflare/s61nov11.shinji.nishioka@gmail.com/dns"
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

variable "cloudflare_api_token" {
  type = string
}