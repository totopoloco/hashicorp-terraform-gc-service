resource "google_compute_network" "vpc_network_custom_1" {
  name    = "terraform-network-custom-1"
  auto_create_subnetworks = "false"
  description             = "VPC network created by Terraform with custom subnet"
  routing_mode            = "REGIONAL"
  project = var.project_id_2
}

resource "google_compute_subnetwork" "subnet_1" {
  name          = "subnet-1"
  ip_cidr_range = "10.0.1.0/24"
  region        = "europe-west6"
  network = google_compute_network.vpc_network_custom_1.self_link
  project = var.project_id_2
}

resource "google_compute_subnetwork" "subnet_2" {
  name          = "subnet-2"
  ip_cidr_range = "10.0.2.0/24"
  region        = "europe-west6"
  network = google_compute_network.vpc_network_custom_1.self_link
  project = var.project_id_2
}

resource "google_compute_firewall" "allow_https_inbound_custom_1" {
  name    = "allow-https-inbound-custom-1"
  network = google_compute_network.vpc_network_custom_1.self_link
  project = var.project_id_2

  allow {
    protocol = "tcp"
    ports = ["22", "80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
}