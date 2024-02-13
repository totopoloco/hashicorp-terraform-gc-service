resource "google_compute_network" "vpc_network" {
  name                    = var.network
  auto_create_subnetworks = "true"
  description             = "VPC network created by Terraform with auto subnets"
  mtu                     = 1460
  routing_mode            = "REGIONAL"
  project                 = var.project_id

}