module "gke-service-account" {
    source = "../service-account"

    project_id = var.project_id
    region = var.region

    google_service_account_account_id = var.google_service_account_account_id
    google_service_account_display_name = var.google_service_account_display_name
}

