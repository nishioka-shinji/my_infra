terraform {
  required_version = "1.13.2"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "7.2.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.11.0"
    }
  }

  backend "gcs" {
    bucket = "shinji-nishioka-test-terraform-state"
    prefix = "terraform/gcp/iam"
  }
}

provider "google" {
  project = "shinji-nishioka-test"
  region  = "asia-northeast2"
}

data "terraform_remote_state" "gke" {
  backend = "gcs"

  config = {
    bucket = "shinji-nishioka-test-terraform-state"
    prefix = "terraform/gcp/gke"
  }
}

provider "kubernetes" {
  host  = "https://${data.terraform_remote_state.gke.outputs.cluster_endpoint}"
  token = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(
    data.terraform_remote_state.gke.outputs.cluster_ca_certificate
  )
}

data "google_client_config" "default" {}
