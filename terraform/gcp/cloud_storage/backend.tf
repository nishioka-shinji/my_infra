terraform {
  required_version = "1.14.3"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "7.17.0"
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