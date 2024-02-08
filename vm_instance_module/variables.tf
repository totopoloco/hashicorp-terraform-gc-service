variable "project_id" {
  description = "The project id"
}

variable "network" {
  description = "The network name"
}

variable "subnetwork" {
  description = "The subnetwork name"
}

variable "nat" {
  description = "The NAT ip address"
}

variable "vm_instance" {
  description = "The region"
  default     = "vm-instance-1"
}

variable "vm_instance_zone" {
  description = "The vm zone"
  default     = "europe-west6-b"
}

variable "vm_instance_type" {
  description = "The vm instance type"
  default     = "f1-micro"
}

variable "vm_instance_image" {
  description = "The vm image"
  default     = "debian-cloud/debian-11"
}