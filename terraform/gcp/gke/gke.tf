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

resource "google_container_cluster" "primary" {
  name = "my-autopilot-cluster"
  location = "asia-northeast2"
  enable_autopilot = true

  network    = data.terraform_remote_state.network.outputs.network_name
  subnetwork = data.terraform_remote_state.network.outputs.subnetwork_name
  ip_allocation_policy {
    cluster_secondary_range_name  = data.terraform_remote_state.network.outputs.pods_range_name
    services_secondary_range_name = data.terraform_remote_state.network.outputs.services_range_name
  }
}