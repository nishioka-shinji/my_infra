terraform {
  required_version = "1.13.4"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "7.9.0"
    }
  }

  backend "gcs" {
    bucket = "shinji-nishioka-test-terraform-state"
    prefix = "terraform/gcp/01-api"
  }
}

provider "google" {
  project = "shinji-nishioka-test"
  region  = "asia-northeast2"
}