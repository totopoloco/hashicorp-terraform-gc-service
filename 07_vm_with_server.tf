resource "google_service_account" "vm_instance_1" {
  account_id = "vm-instance-1"
  display_name = "Custom SA for VM Instance"
}

resource "google_compute_instance" "vm_instance_1" {
  name         = "vm-instance-1"
  machine_type = "f1-micro"
  zone         = "europe-west6-b"
  project = var.project_id_2

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network_custom_1.self_link
    subnetwork = google_compute_subnetwork.subnet_1.self_link

    access_config {
      nat_ip = google_compute_address.external.address
    }
  }

  metadata_startup_script = file("${path.module}/startup_script.sh")

  service_account {
    email  = google_service_account.vm_instance_1.email
    scopes = ["cloud-platform"]
  }
}