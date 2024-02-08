resource "google_compute_firewall" "allow_https_inbound_custom_1" {
  name    = var.network_custom_1_firewall_rule_1_name
  network = module.custom_network_1.network_self_link
  project = var.project_id_2

  allow {
    protocol = "tcp"
    ports = ["22", "80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
}