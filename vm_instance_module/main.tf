resource "google_service_account" "vm_instance_1" {
  account_id   = var.vm_instance
  display_name = "Custom SA for VM Instance"
}

resource "google_compute_instance" "vm_instance_1" {
  name         = var.vm_instance
  machine_type = var.vm_instance_type
  zone         = var.vm_instance_zone
  project      = var.project_id

  boot_disk {
    initialize_params {
      image = var.vm_instance_image
    }
  }

  network_interface {
    network    = var.network
    subnetwork = var.subnetwork
    access_config {
      nat_ip = var.nat
    }
  }

  metadata_startup_script = file("${path.module}/startup_script.sh")

  service_account {
    email  = google_service_account.vm_instance_1.email
    scopes = ["cloud-platform"]
  }
}