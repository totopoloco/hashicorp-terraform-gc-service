terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  #  credentials = file("credentials.json")

  project = "marco-t-avila-project-3"
  region  = "europe-west6"
  zone    = "europe-west6-c"
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
  auto_create_subnetworks = "true"
  description = "VPC network created by Terraform with auto subnets"
  mtu = 1460
  routing_mode = "REGIONAL"
  project = "marco-t-avila-project-3"

}

resource "google_compute_network" "vpc_network_custom" {
  name                    = "terraform-network-custom"
  auto_create_subnetworks = "false"
  description             = "VPC network created by Terraform with custom subnet"
  routing_mode            = "REGIONAL"
  project                 = "marco-t-avila-project-3"
}

resource "google_compute_network" "subnet_1" {
  name          = "subnet-1"
  ip_cidr_range = "10.0.1.0/24"
  region        = "europe-west6"
  network       = google_compute_network.vpc_network_custom.self_link
  project       = "marco-t-avila-project-3"
}

resource "google_compute_network" "subnet_2" {
  name          = "subnet-2"
  ip_cidr_range = "10.0.2.0/24"
  region        = "europe-west6"
  network       = google_compute_network.vpc_network_custom.self_link
  project       = "marco-t-avila-project-3"
}