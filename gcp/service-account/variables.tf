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
    description = "Google project iam binding"
}

variable "google_project_iam_member" {
    type = list(object({
      role = string
      member = optional(string, "")
    }))
    default = []
    description = "Google project iam member"
}

variable "google_service_account_iam_binding" {
    type = list(object({
      role = string
      members = list(string)
    }))
    default = []
    description = "Google service account iam binding"
}

variable "google_service_account_iam_member" {
    type = list(object({
      role = string
      member = string
    }))
    default = []
    description = "Google service account iam member"
}