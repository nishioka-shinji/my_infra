locals {
  secondary_ranges_map = {
    for range in data.terraform_remote_state.network.outputs.subnet.secondary_ip_range : range.range_name => range
  }
}

resource "google_container_cluster" "primary" {
  name                = "my-autopilot-cluster"
  enable_autopilot    = true
  deletion_protection = false

  monitoring_config {
    enable_components = ["SYSTEM_COMPONENTS"]
  }

  network    = data.terraform_remote_state.network.outputs.network.name
  subnetwork = data.terraform_remote_state.network.outputs.subnet.name
  ip_allocation_policy {
    cluster_secondary_range_name  = local.secondary_ranges_map["pods-range"].range_name
    services_secondary_range_name = local.secondary_ranges_map["services-range"].range_name
  }
}