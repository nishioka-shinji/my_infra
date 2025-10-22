terraform {
  required_version = "1.13.4"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "7.8.0"
    }
  }

  backend "gcs" {
    bucket = "shinji-nishioka-test-terraform-state"
    prefix = "terraform/gcp/cloud_storage"
  }
}

provider "google" {
  project = "shinji-nishioka-test"
  region  = "asia-northeast2"
}