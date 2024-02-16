#Create the role if it does not exist
locals {
  client_email = var.client_email
}

output "client_email" {
  value = local.client_email
}

resource "google_project_iam_member" "member" {
  member  = "serviceAccount:${local.client_email}"
  project = var.project_id
  role    = var.role_storage
}
# End of the role creation

# Create the bucket
resource "google_storage_bucket" "bucket" {
  location      = var.bucket_location
  name          = var.bucket_name
  storage_class = var.bucket_storage_class

  versioning {
    enabled = var.bucket_versioning
  }
}

resource "random_pet" "random_content" {
  length  = 10000
  separator = " "
}
resource "random_string" "random_filename" {
  length  = 5
  special = false
}

resource "google_storage_bucket_object" "object" {
  name    = format("%s.txt", random_string.random_filename.result)
  bucket  = google_storage_bucket.bucket.name
  content = random_pet.random_content.id
}
# End of the bucket creation