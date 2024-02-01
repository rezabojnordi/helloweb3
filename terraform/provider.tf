locals {
  project_id = "secret-medium-412918"
  region     = "us-central1"
  default_labels = {
    managed-by = "terraform"
  }
  zone      = "us-central1-a"
  credential = "keys.json"
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
    bucket = "helloweb_12_21"
  }
}


provider "google" {
  project = local.project_id
  region  = local.region
  zone = local.zone
  credentials = local.credential
}

provider "google-beta" {
  project = local.project_id
  region  = local.region
}

data "google_project" "this" {}

data "google_compute_default_service_account" "default" {}

