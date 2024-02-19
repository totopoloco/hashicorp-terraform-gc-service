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
    database_flags {
      name  = "sslmode"
      value = "require"
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
  name_prefix = "client-cert"
  common_name = "client"
  instance    = google_sql_database_instance.default.name
}

output "client_cert" {
  value = google_sql_ssl_cert.client_cert.cert
}

output "client_private_key" {
  value = google_sql_ssl_cert.client_cert.private_key
}