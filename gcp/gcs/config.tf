terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "6.27.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# Comment this block ONLY in the first run to create the tfstate bucket
terraform {
  backend "gcs" {}
}