terraform {
  required_version = "1.14.6"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "7.22.0"
    }
  }

  backend "gcs" {
    bucket = "shinji-nishioka-test-terraform-state"
    prefix = "terraform/gcp/gke"
  }
}

provider "google" {
  project = "shinji-nishioka-test"
  region  = "asia-northeast2"
}