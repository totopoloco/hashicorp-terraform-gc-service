output "external_address" {
  description = "The self link of the created external IP address."
  value       = google_compute_address.external.address
}