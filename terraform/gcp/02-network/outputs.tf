output "network" {
  description = "The VPC network object"
  value       = google_compute_network.vpc_network
}

output "subnet" {
  description = "The GKE subnet object"
  value       = google_compute_subnetwork.gke_subnet
}
