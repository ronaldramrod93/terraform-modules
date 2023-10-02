variable "project_id" {
    type = string
    description = "GCP Project ID"
}

variable "region" {
    type = string
    description = "GCP region"
}

variable "google_service_account_account_id" {
    type = string
    description = "Google service account ID"
}

variable "google_service_account_display_name" {
    type = string
    description = "Google service account display name"
}

variable "google_project_iam_binding" {
    type = list(object({
      role = string
      members = optional(list(string), [])
    }))
    default = []
    description = "Grant roles to a list of members for the GCP project"
}

variable "google_service_account_iam_binding" {
    type = list(object({
      role = string
      members = list(string)
    }))

    description = "Grant roles to a list of members for the service account"
}