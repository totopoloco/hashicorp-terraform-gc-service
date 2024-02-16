variable "project_id" {
  description = "The project ID to deploy to"
}

variable "role_storage" {
  description = "The role to assign to the service account for storage"
}

variable "client_email" {
  description = "The email for the role to assign to the service account for storage"
}

variable "bucket_name" {
  description = "The name of the bucket to create"
  type        = string
}

variable "bucket_location" {
  description = "The name of the bucket location"
  type        = string
}

variable "bucket_storage_class" {
  description = "The name of the bucket storage class"
  type        = string
}

variable "bucket_versioning" {
  description = "If versioning should be enabled for the bucket"
  type        = bool
}