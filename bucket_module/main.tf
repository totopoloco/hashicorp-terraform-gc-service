#Create the role if it does not exist
locals {
  client_email = lookup(var, "client_email")
}

output "client_email" {
  value = local.client_email
}

data "google_project_iam_policy" "project" {
  project = var.project_id
}

resource "google_project_iam_member" "member" {
  member  = "user:${local.client_email}"
  project = var.project_id
  role    = var.role_storage
}
# End of the role creation