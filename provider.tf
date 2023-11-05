provider "google" {
  project     = var.project
  credentials = file("abdelrhmxn-gcp-project-fee4707bc2ea.json")
  region      = var.region
  zone        = var.zone
}

