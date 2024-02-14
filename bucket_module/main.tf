#Create the role if it does not exist
locals {
  client_email = var.client_email
}

output "client_email" {
  value = local.client_email
}

resource "null_resource" "check_iam_policy" {
  triggers = {
    command = <<EOF
      EXISTS=$(gcloud projects get-iam-policy ${var.project_id} --format=json | \
      jq -r '.bindings[] | select(.role == "${var.role_storage}") | .members[]' | \
      grep -q "serviceAccount:${local.client_email}" && echo "true" || echo "false")
      if [ "$EXISTS" = "true" ]; then
        echo "Warning: The storage role is already assigned to the client email"
      fi
    EOF
  }

  provisioner "local-exec" {
    command     = self.triggers.command
    interpreter = ["/bin/sh", "-c"]
  }
}

resource "google_project_iam_member" "member" {
  count   = null_resource.check_iam_policy.triggers.command == "" ? 1 : 0
  member  = "serviceAccount:${local.client_email}"
  project = var.project_id
  role    = var.role_storage
}
# End of the role creation