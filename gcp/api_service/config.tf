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
}

# Comment this block ONLY in the first run to create the tfstate bucket
terraform {
  backend "gcs" {}
}