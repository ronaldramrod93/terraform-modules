variable "project_id" {
  type        = string
  description = "GCP project ID"
}

variable "api_services" {
  type        = list(string)
  description = "List of API services to enable in the GCP project."
}

variable "disable_on_destroy" {
  type        = bool
  description = "Disable the API services on destroy instead of let them enabled."
  default     = true
}

variable "disable_dependent_services" {
  type        = bool
  description = "Disable dependent services when disabling the API services."
  default     = true
}