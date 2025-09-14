output "network_name" {
  description = "The name of the VPC network"
  value       = google_compute_network.vpc_network.name
}

output "subnetwork_name" {
  description = "The name of the GKE subnet"
  value       = google_compute_subnetwork.gke_subnet.name
}

output "pods_range_name" {
  description = "The name of the secondary range for pods"
  value       = google_compute_subnetwork.gke_subnet.secondary_ip_range[0].range_name
}

output "services_range_name" {
  description = "The name of the secondary range for services"
  value       = google_compute_subnetwork.gke_subnet.secondary_ip_range[1].range_name
}
