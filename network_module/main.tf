resource "google_compute_network" "vpc_network_custom" {
  name                    = var.network_name
  auto_create_subnetworks = "false"
  description             = var.network_description
  routing_mode            = "REGIONAL"
  project                 = var.project_id
}

resource "google_compute_subnetwork" "subnet_1" {
  name          = var.subnet_1_name
  ip_cidr_range = var.subnet_1_cidr
  region        = var.subnet_1_region
  network       = google_compute_network.vpc_network_custom.self_link
  project       = var.project_id
}

resource "google_compute_subnetwork" "subnet_2" {
  name          = var.subnet_2_name
  ip_cidr_range = var.subnet_2_cidr
  region        = var.subnet_2_region
  network       = google_compute_network.vpc_network_custom.self_link
  project       = var.project_id
}