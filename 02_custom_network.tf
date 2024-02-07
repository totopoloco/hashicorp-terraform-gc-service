resource "google_compute_network" "vpc_network_custom" {
  name                    = "terraform-network-custom"
  auto_create_subnetworks = "false"
  description             = "VPC network created by Terraform with custom subnet"
  routing_mode            = "REGIONAL"
  project                 = "marco-t-avila-project-3"
}

resource "google_compute_subnetwork" "subnet_1" {
  name          = "subnet-1"
  ip_cidr_range = "10.0.1.0/24"
  region        = "europe-west6"
  network       = google_compute_network.vpc_network_custom.self_link
  project       = "marco-t-avila-project-3"
}

resource "google_compute_subnetwork" "subnet_2" {
  name          = "subnet-2"
  ip_cidr_range = "10.0.2.0/24"
  region        = "europe-west6"
  network       = google_compute_network.vpc_network_custom.self_link
  project       = "marco-t-avila-project-3"
}

resource "google_compute_firewall" "block_http_inbound_custom" {
  name    = "block-http-inbound-custom"
  network = google_compute_network.vpc_network_custom.self_link

  deny {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  direction     = "INGRESS"
}

resource "google_compute_firewall" "block_http_outbound_custom" {
  name    = "block-http-outbound-custom"
  network = google_compute_network.vpc_network_custom.self_link

  deny {
    protocol = "tcp"
    ports    = ["80"]
  }

  destination_ranges = ["0.0.0.0/0"]
  direction          = "EGRESS"
}