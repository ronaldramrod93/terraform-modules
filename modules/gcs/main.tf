resource "google_storage_bucket" "pf-tfstate" {
  name          = var.bucket_name
  project       = var.project_id
  location      = var.location
  force_destroy = var.force_destroy
  
  versioning {
    enabled = var.enable_versioning
  }
}