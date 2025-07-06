provider "google" {
  region = var.region
  project = var.project_id 
}

terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "6.42.0"
    }
  }
  backend "gcs" {}
}