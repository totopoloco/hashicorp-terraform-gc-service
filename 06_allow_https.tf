resource "google_compute_firewall" "allow_https_inbound_custom_1" {
  name    = "allow-https-inbound-custom-1"
  network = google_compute_network.vpc_network_custom_1.self_link
  project = var.project_id_2

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  source_ranges = ["0.0.0.0/0"]
  direction     = "INGRESS"
}