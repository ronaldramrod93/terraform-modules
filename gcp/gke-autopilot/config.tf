terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "6.42.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

terraform {
  backend "gcs" {}
}
