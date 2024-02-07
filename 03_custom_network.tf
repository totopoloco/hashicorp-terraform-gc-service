resource "google_compute_network" "vpc_network_custom_2" {
  name                    = "terraform-network-custom-2"
  auto_create_subnetworks = "false"
  description             = "VPC network created by Terraform with custom subnet"
  routing_mode            = "REGIONAL"
  project                 = "marco-t-avila-project-3"
}

resource "google_compute_subnetwork" "subnet_3" {
  name          = "subnet-3"
  ip_cidr_range = "10.0.5.0/24"
  region        = "europe-west6"
  network       = google_compute_network.vpc_network_custom_2.self_link
  project       = "marco-t-avila-project-3"
}

resource "google_compute_subnetwork" "subnet_4" {
  name          = "subnet-4"
  ip_cidr_range = "10.0.6.0/24"
  region        = "europe-west6"
  network       = google_compute_network.vpc_network_custom_2.self_link
  project       = "marco-t-avila-project-3"
}