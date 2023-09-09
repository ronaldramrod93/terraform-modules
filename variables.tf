variable "project_id" {
    type = string
    description = "GCP project ID"  
}

variable "region" {
    type = string
    description = "GCP region"
}

variable "bucket_name" {
    type = string
    description = "GCS bucket name"
}

variable "location" {
  type = string
  description = "location of the GCS bucket"
}

variable "enable_versioning" {
    type = bool
    description = "enable versioning in GCS"
}

variable "force_destroy" {
    type = bool
    description = "Enable the force destroy the bucket"  
}

variable "labels" {
    type        = map(any)
    description = "Labels to assign on the GCS bucket."
}