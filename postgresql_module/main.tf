resource "google_sql_database_instance" "default" {
  database_version = var.instance_database_version
  name             = var.instance_name
  region           = var.instance_region
  settings {
    tier = var.instance_tier

    ip_configuration {
      ipv4_enabled    = true
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