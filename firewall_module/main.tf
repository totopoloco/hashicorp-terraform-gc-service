resource "google_compute_firewall" "allow_http_inbound_custom" {
  name    = var.firewall_rule_name
  network = var.network
  project = var.project_id

  allow {
    protocol = "tcp"
    ports = ["22", "80", "443", "5432"]
  }

  source_ranges = ["0.0.0.0/0"]
}