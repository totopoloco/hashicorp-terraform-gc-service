resource "google_compute_address" "external" {
  name         = "external-ip-address-1"
  region       = "europe-west6"
  project      = var.project_id_2
  network_tier = "PREMIUM" // or "STANDARD"
}