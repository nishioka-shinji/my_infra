data "google_project" "project" {}

data "terraform_remote_state" "network" {
  backend = "gcs"
  config = {
    bucket = "shinji-nishioka-test-terraform-state"
    prefix = "terraform/gcp/02-network"
  }
}
