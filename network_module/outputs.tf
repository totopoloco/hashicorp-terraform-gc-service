output "network_self_link" {
  description = "The self link of the created network"
  value       = google_compute_network.vpc_network_custom.self_link
}

output "network_subnet_1_self_link" {
  description = "The self link of the created subnetwork"
  value       = google_compute_subnetwork.subnet_1.self_link
}

output "network_subnet_2_self_link" {
  description = "The self link of the created subnetwork"
  value       = google_compute_subnetwork.subnet_2.self_link
}