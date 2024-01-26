resource "google_storage_bucket" "pf-tfstate" {
  name          = var.bucket_name
  project       = var.project_id
  location      = var.location
  force_destroy = var.force_destroy

  storage_class = var.storage_class

  versioning {
    enabled = var.enable_versioning
  }

  labels = var.labels
}