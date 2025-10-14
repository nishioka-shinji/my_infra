terraform {
  required_version = "~> 1.13.2"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "7.7.0"
    }
  }

  backend "gcs" {
    bucket = "shinji-nishioka-test-terraform-state"
    prefix = "terraform/gcp/02-network"
  }
}

provider "google" {
  project = "shinji-nishioka-test"
  region  = "asia-northeast2"
}