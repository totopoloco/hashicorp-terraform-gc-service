variable "project_id_2" {
  description = "The project id of the first project"
  default     = "marco-t-avila-project-3"
}

variable "project_id_2_region" {
  description = "The region of the second project"
  default     = "europe-west6"
}

variable "project_id_2_zone" {
  description = "The zone of the second project"
  default     = "europe-west6-c"
}

variable "network_id_1" {
  description = "The network in auto mode"
  default     = "terraform-network"
}

variable "terraform-network-custom-1" {
  description = "The network in custom mode"
  default     = "terraform-network-custom-1"
}

variable "network_custom_1_subnet_id_1" {
  description = "The subnet for network 1 in custom mode"
  default     = "network-1-subnet-1"
}

variable "network_custom_1_subnet_id_1_range_cidr" {
  description = "The subnet for network 1 in custom mode"
  default     = "10.0.1.0/24"
}

variable "network_custom_1_subnet_id_1_region" {
  description = "The subnet for network 1 in custom mode"
  default     = "europe-west6"
}

variable "network_custom_1_subnet_id_2" {
  description = "The subnet for network 2 in custom mode"
  default     = "network-1-subnet-2"
}

variable "network_custom_1_subnet_id_2_range_cidr" {
  description = "The subnet for network 1 in custom mode"
  default     = "10.0.2.0/24"
}

variable "network_custom_1_subnet_id_2_region" {
  description = "The subnet for network 1 in custom mode"
  default     = "europe-west6"
}

variable "network_custom_1_firewall_rule_1_name" {
  description = "The subnet for network 1 in custom mode"
  default     = "allow-https-inbound-custom-1"
}

variable "terraform-network-custom-2" {
  description = "The network in custom mode"
  default     = "terraform-network-custom-2"
}

variable "network_custom_2_subnet_id_1" {
  description = "The subnet for network 1 in custom mode"
  default     = "network-2-subnet-1"
}

variable "network_custom_2_subnet_id_1_range_cidr" {
  description = "The subnet for network 1 in custom mode"
  default     = "10.0.5.0/24"
}

variable "network_custom_2_subnet_id_1_region" {
  description = "The subnet for network 1 in custom mode"
  default     = "europe-west6"
}

variable "network_custom_2_subnet_id_2" {
  description = "The subnet for network 2 in custom mode"
  default     = "network-2-subnet-2"
}

variable "network_custom_2_subnet_id_2_range_cidr" {
  description = "The subnet for network 1 in custom mode"
  default     = "10.0.6.0/24"
}

variable "network_custom_2_subnet_id_2_region" {
  description = "The subnet for network 1 in custom mode"
  default     = "europe-west6"
}

variable "storage_role" {
  description = "The role for the storage bucket"
  default     = "roles/storage.admin"
}

variable "client_email" {
  description = "The client email"
  type        = string
}

variable "bucket_location" {
  default = "EU"
}

variable "bucket_storage_class" {
  default = "STANDARD"
}

variable "bucket_versioning" {
  default = true
}