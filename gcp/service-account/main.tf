resource "google_service_account" "service_account" {
  account_id   = var.google_service_account_account_id
  display_name = var.google_service_account_display_name
  description  = "created by terraform - ${var.google_service_account_display_name}"
  project      = var.project_id
}

resource "google_project_iam_binding" "project_iam_binding" {
  count = length(var.google_project_iam_binding)

  project = var.project_id
  role    = var.google_project_iam_binding[count.index].role

  members = length(var.google_project_iam_binding[count.index].members) == 0 ? ["serviceAccount:${google_service_account.service_account.email}"] : var.google_project_iam_binding[count.index].members
}

resource "google_project_iam_member" "project_iam_member" {
  count = length(var.google_project_iam_member)

  project = var.project_id
  role    = var.google_project_iam_member[count.index].role

  member = var.google_project_iam_member[count.index].member == "" ? "serviceAccount:${google_service_account.service_account.email}" : var.google_project_iam_member[count.index].member
}

resource "google_service_account_iam_binding" "service_account_iam_binding" {
  count = length(var.google_service_account_iam_binding)

  service_account_id = google_service_account.service_account.name
  role               = var.google_service_account_iam_binding[count.index].role

  members = var.google_service_account_iam_binding[count.index].members
}

resource "google_service_account_iam_member" "service_account_iam_member" {
  count = length(var.google_service_account_iam_member)

  service_account_id = google_service_account.service_account.name
  role               = var.google_service_account_iam_member[count.index].role

  member = var.google_service_account_iam_member[count.index].member
}