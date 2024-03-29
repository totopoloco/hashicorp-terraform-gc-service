#Create the role if it does not exist
locals {
  client_email = var.client_email
}

output "client_email" {
  value = local.client_email
}

resource "google_project_iam_member" "member_database_admin" {
  member  = "serviceAccount:${local.client_email}"
  project = var.instance_project_id
  role    = var.role_database_admin
}

resource "google_project_iam_member" "member_network_admin" {
  member  = "serviceAccount:${local.client_email}"
  project = var.instance_project_id
  role    = var.role_network_admin
}
# End of the role creation

#Create the database networking
resource "google_project_service" "service_networking" {
  project                    = var.instance_project_id
  service                    = "servicenetworking.googleapis.com"
  disable_dependent_services = true
}

resource "google_compute_global_address" "private_ip_address" {
  name = "private-ip-address"
  purpose = "VPC_PEERING"
  address_type = "INTERNAL"
  prefix_length = 16
  network = var.instance_network
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = var.instance_network
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
  service                 = "servicenetworking.googleapis.com"
}
#End of the database networking creation

resource "google_sql_database_instance" "default" {
  database_version = var.instance_database_version
  name             = var.instance_name
  region           = var.instance_region
  depends_on = [google_project_service.service_networking, google_service_networking_connection.private_vpc_connection]
  settings {
    tier = var.instance_tier
    # Remove the protection to allow the deletion of the instance
    deletion_protection_enabled = false

    ip_configuration {
      ipv4_enabled    = true
      require_ssl     = true
      private_network = var.instance_network
      authorized_networks {
        name  = var.instance_public_network_name
        value = var.instance_public_network_range
      }
    }
  }
}

resource "google_sql_database" "default" {
  instance = google_sql_database_instance.default.name
  name     = var.instance_database_name
  project  = var.instance_project_id
}

resource "random_string" "random_db_password" {
  length  = 10
  special = false
}

resource "google_sql_user" "default" {
  instance = google_sql_database_instance.default.name
  name     = "user"
  password = lower(random_string.random_db_password.result)
}

resource "google_sql_ssl_cert" "client_cert" {
  common_name = "client"
  instance    = google_sql_database_instance.default.name
}

output "client_cert" {
  value = google_sql_ssl_cert.client_cert.cert
}

output "client_private_key" {
  value = google_sql_ssl_cert.client_cert.private_key
}