terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "4.51.0"
    }
  }
}

provider "google" {
  #  credentials = file("credentials.json")
  project = var.project_id_2
  region  = var.project_id_2_region
  zone    = var.project_id_2_zone
}

module "custom_network_1" {
  source              = "./network_module"
  network_name        = var.terraform-network-custom-1
  network_description = "VPC network (1) created by Terraform with custom subnet"
  project_id          = var.project_id_2
  subnet_1_name       = var.network_custom_1_subnet_id_1
  subnet_1_cidr       = var.network_custom_1_subnet_id_1_range_cidr
  subnet_1_region     = var.network_custom_1_subnet_id_1_region
  subnet_2_name       = var.network_custom_1_subnet_id_2
  subnet_2_cidr       = var.network_custom_1_subnet_id_2_range_cidr
  subnet_2_region     = var.network_custom_1_subnet_id_2_region
}

module "custom_network_2" {
  source              = "./network_module"
  network_name        = var.terraform-network-custom-2
  network_description = "VPC network (2) created by Terraform with custom subnet"
  project_id          = var.project_id_2
  subnet_1_name       = var.network_custom_2_subnet_id_1
  subnet_1_cidr       = var.network_custom_2_subnet_id_1_range_cidr
  subnet_1_region     = var.network_custom_2_subnet_id_1_region
  subnet_2_name       = var.network_custom_2_subnet_id_2
  subnet_2_cidr       = var.network_custom_2_subnet_id_2_range_cidr
  subnet_2_region     = var.network_custom_2_subnet_id_2_region
}

module "network_peering" {
  source              = "./network_peering_module"
  network_1_self_link = module.custom_network_1.network_self_link
  network_2_self_link = module.custom_network_2.network_self_link
}

module "external_network" {
  source     = "./external_ip_module"
  project_id = var.project_id_2
}

module "vm_instance" {
  source     = "./vm_instance_module"
  project_id = var.project_id_2
  network    = module.custom_network_1.network_self_link
  subnetwork = module.custom_network_1.network_subnet_1_self_link
  nat        = module.external_network.external_address
}

module "firewall" {
  source             = "./firewall_module"
  firewall_rule_name = var.network_custom_1_firewall_rule_1_name
  network            = module.custom_network_1.network_self_link
  project_id         = var.project_id_2
}

module "auto_network" {
  source     = "./auto_network_module"
  network    = var.network_id_1
  project_id = var.project_id_2
}

resource "random_string" "random_bucket_name_part_1" {
  length  = 3
  special = false
}
resource "random_string" "random_bucket_name_part_2" {
  length  = 3
  special = false
}

resource "random_string" "random_bucket_name_part_3" {
  length  = 3
  special = false
}


module "bucket" {
  source               = "./bucket_module"
  project_id           = var.project_id_2
  role_storage         = var.storage_role
  client_email         = var.client_email
  bucket_name          = lower(format("%s-%s-%s", random_string.random_bucket_name_part_1.result, random_string.random_bucket_name_part_2.result, random_string.random_bucket_name_part_3.result))
  bucket_location      = var.bucket_location
  bucket_storage_class = var.bucket_storage_class
  bucket_versioning    = var.bucket_versioning
}

module "postgresql" {
  source                        = "./postgresql_module"
  instance_database_version     = var.instance_database_version
  instance_name                 = var.instance_name
  instance_region               = var.instance_region
  instance_tier                 = var.instance_tier
  instance_network              = module.custom_network_1.network_self_link
  instance_public_network_name  = var.instance_public_network_name
  instance_public_network_range = var.instance_public_network_range
  instance_database_name        = var.instance_database_name
  instance_project_id = var.project_id_2
  client_email        = var.client_email
  role_database_admin = var.role_database_admin
}