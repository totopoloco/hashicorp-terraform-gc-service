variable "instance_database_version" {
  description = "The version of the database software to be installed"
}

variable "instance_name" {
  description = "The name of the instance"
}

variable "instance_region" {
  description = "The region in which the instance will be created"
}

variable "instance_tier" {
  description = "The tier of the instance"
}

variable "instance_network" {
  description = "The network in which the instance will be created"
}

variable "instance_public_network_name" {
  description = "The name of the public network"
}

variable "instance_public_network_range" {
  description = "The range of the public network"
}

variable "instance_database_name" {
  description = "The name of the database"
}

variable "instance_project_id" {
  description = "The project id"
}

variable "client_email" {
  description = "The email for the role to assign to the service account for storage"
}

variable "role_database_admin" {
  description = "The role to assign to the service account for database admin"
}