resource "google_compute_network" "vpc_network" {
  name                    = "my-gke-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "gke_subnet" {
  name          = "my-gke-subnet"
  ip_cidr_range = "10.0.1.0/24"
  network       = google_compute_network.vpc_network.id

  secondary_ip_range {
    range_name    = "pods-range"
    ip_cidr_range = "10.1.0.0/16"
  }

  secondary_ip_range {
    range_name    = "services-range"
    ip_cidr_range = "10.2.0.0/20"
  }
}