variable "project_id" {
  type        = string
  description = "GCP project ID"
}

variable "region" {
  type        = string
  description = "GCP region"
}

variable "bucket_name" {
  type        = string
  description = "GCS bucket name"
}

variable "location" {
  type        = string
  description = "location of the GCS bucket"
}

variable "storage_class" {
  type        = string
  description = "storage class of the GCS bucket"
  default     = "STANDARD"
}

variable "enable_versioning" {
  type        = bool
  description = "enable versioning in GCS"
  default     = false
}

variable "force_destroy" {
  type        = bool
  description = "Enable the force destroy the bucket"
  default     = false
}

variable "labels" {
  type        = map(any)
  description = "Labels to assign on the GCS bucket."
  default     = {}
}