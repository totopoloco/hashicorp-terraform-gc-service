terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  credentials = file("credentials.json")

  project = "marco-t-avila-project-3"
  region  = "europe-west6"
  zone    = "europe-west6-c"
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
  auto_create_subnetworks = "true"
  description = "VPC network created by Terraform"
  mtu = 1460
  routing_mode = "REGIONAL"
  project = "marco-t-avila-project-3"

}
