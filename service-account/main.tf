resource "google_service_account" "service_account" {
  account_id   = var.google_service_account_account_id
  display_name = var.google_service_account_display_name
  description  = "created by terraform - ${var.google_service_account_display_name}"
  project      = var.project_id
}

// Grant role permissions to service account to project level
resource "google_project_iam_binding" "project" {
  // count = to be defined

  project = var.project_id
  role    = var.google_project_iam_binding_role

  members = ["serviceAccount:${google_service_account.service_account.email}"]
}

// Grant service account user role to member for the service account
resource "google_service_account_iam_binding" "admin-account-iam" {
  // count = to be defined

  service_account_id = google_service_account.service_account.name
  role               = var.google_service_account_iam_binding_role

  members = var.google_service_account_iam_binding_members
}