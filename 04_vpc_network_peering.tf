resource "google_compute_network_peering" "network1_to_network2" {
  name         = "network1-to-network2"
  network      = google_compute_network.vpc_network_custom_1.self_link
  peer_network = google_compute_network.vpc_network_custom_2.self_link
}

resource "google_compute_network_peering" "network2_to_network1" {
  name         = "network2-to-network1"
  network      = google_compute_network.vpc_network_custom_2.self_link
  peer_network = google_compute_network.vpc_network_custom_1.self_link
}