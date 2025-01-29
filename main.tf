terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "6.18.0"
    }
  }
}

provider "google" {
  credentials = "my-creds.json"
  project = "terraform-demo-412003"
  region  = "us-central1"
}



resource "google_storage_bucket" "data-lake-bucket" {
  name          = "terraform-demo-412003-terra-bucket"
  location      = "US"
  force_destroy = true

  # Optional, but recommended settings:
  storage_class = "STANDARD"
  uniform_bucket_level_access = true

  versioning {
    enabled     = true
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 30  // days
    }
  }
}


resource "google_bigquery_dataset" "dataset" {
  dataset_id = "dataset_terraform_demo_412003"
  project    = "terraform-demo-412003"
  location   = "US"
}