resource "google_compute_network_peering" "network1_to_network2" {
  name         = "network1-to-network2"
  network      = module.custom_network_1.network_self_link
  peer_network = module.custom_network_2.network_self_link
}

resource "google_compute_network_peering" "network2_to_network1" {
  name         = "network2-to-network1"
  network      = module.custom_network_2.network_self_link
  peer_network = module.custom_network_1.network_self_link
}