output "vpc_network_name" {
  description = "The name of the VPC network"
  value       = google_compute_network.vpc_network.name
}

output "vpc_network_self_link" {
  description = "The self_link of the VPC network"
  value       = google_compute_network.vpc_network.self_link
}

output "gke_subnet_name" {
  description = "The name of the GKE subnet"
  value       = google_compute_subnetwork.gke_subnet.name
}

output "gke_subnet_self_link" {
  description = "The self_link of the GKE subnet"
  value       = google_compute_subnetwork.gke_subnet.self_link
}

output "gke_subnet_pods_range_name" {
  description = "The name of the secondary IP range for pods"
  value       = google_compute_subnetwork.gke_subnet.secondary_ip_range[0].range_name
}

output "gke_subnet_services_range_name" {
  description = "The name of the secondary IP range for services"
  value       = google_compute_subnetwork.gke_subnet.secondary_ip_range[1].range_name
}
