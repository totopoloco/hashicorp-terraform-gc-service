variable "project_id" {
  description = "The project ID to deploy to"
}

variable "role_storage" {
  description = "The role to assign to the service account for storage"
}

variable "client_email" {
  description = "The email for the role to assign to the service account for storage"
}