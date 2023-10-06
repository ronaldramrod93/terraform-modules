variable "project_id" {
    type = string
    description = "GCP Project ID"
}

variable "region" {
    type = string
    description = "GCP region"
}

variable "google_container_cluster_name" {
  type = string
  description = "Google container cluster name"
}

variable "google_service_account_account_id" {
  type = string
  description = "Google service account ID"
}