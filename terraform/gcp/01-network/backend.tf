terraform {
  required_version = "1.13.2"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "7.2.0"
    }
  }

  backend "gcs" {
    bucket  = "shinji-nishioka-test-terraform-state"
    prefix  = "terraform/gcp/01-network"
  }
}

provider "google" {
  project = "shinji-nishioka-test"
  region  = "asia-northeast2"
}