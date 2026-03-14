data "google_project" "project" {}

data "google_container_engine_versions" "asia_northeast2" {
  location       = "asia-northeast2"
  version_prefix = "1.35."
}

data "terraform_remote_state" "network" {
  backend = "gcs"
  config = {
    bucket = "shinji-nishioka-test-terraform-state"
    prefix = "terraform/gcp/02-network"
  }
}
