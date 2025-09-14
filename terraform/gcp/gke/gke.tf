resource "google_container_cluster" "primary" {
  name = "my-autopilot-cluster"
  enable_autopilot = true

  network    = data.terraform_remote_state.network.outputs.network.name
  subnetwork = data.terraform_remote_state.network.outputs.subnet.name
  ip_allocation_policy {
    cluster_secondary_range_name  = "pods-range"
    services_secondary_range_name = "services-range"
  }
}