data "terraform_remote_state" "network" {
  backend = "gcs"
  config = {
    bucket  = "shinji-nishioka-test-terraform-state"
    prefix  = "terraform/gcp/01-network"
  }
}

provider "google" {
  project = "shinji-nishioka-test"
  region  = "asia-northeast2"
}
