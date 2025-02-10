variable "project_id" {
  type = string
  description = "GCP Project ID"
}

variable "region" {
  type = string
  description = "GCP region"
}

variable "google_compute_network_name" {
  type = string
  description = "Compute network name"
}

variable "google_compute_subnetwork_name" {
  type = string
  description = "Compute subnetwork name"
}

variable "google_compute_subnetwork_description" {
  type = string
  description = "Compute subnetwork description"
}

variable "google_compute_subnetwork_ip_cidr_range" {
  type = string
  description = "Primary IP CIDR range in subnetwork"
}

variable "google_compute_subnetwork_secondary_ip_range" {
  type = list(object({
    range_name = string
    ip_cidr_range = string
  }))
  description = "Secondary IP range in subnetwork"
}

variable "google_compute_subnetwork_private_ip_google_access" {
  type = bool
  description = "Enable access to google APIs only for internal IP addresses"
}