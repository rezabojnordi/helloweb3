locals {
  project_id = "YOUR_PROJECT_ID"
  region     = "YOUUR_REGION"
  default_labels = {
    managed-by = "terraform"
  }
}

terraform {
  required_version = "~> 1.5"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.2"
    }
  }

  backend "gcs" {
    bucket = "YOUR_BUCKET"
  }
}


provider "google" {
  project = local.project_id
  region  = local.region
}

provider "google-beta" {
  project = local.project_id
  region  = local.region
}

data "google_project" "this" {}

data "google_compute_default_service_account" "default" {}
