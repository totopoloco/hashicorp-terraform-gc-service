terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  #  credentials = file("credentials.json")

  project = "marco-t-avila-project-3"
  region  = "europe-west6"
  zone    = "europe-west6-c"
}