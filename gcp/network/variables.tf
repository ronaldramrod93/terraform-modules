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

variable "google_compute_network_description" {
  type = string
  description = "Compute network description"
}

variable "google_compute_network_auto_create_subnetworks" {
  type = bool
  description = "Enable auto creation of subnetworks"
}

variable "google_compute_network_routing_mode" {
  type = string
  description = "Routing mode. Possible values [REGIONAL, GLOBAL]"
}
