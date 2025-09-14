locals {
  enable_apis = [
    "cloudkms.googleapis.com",  # Cloud Key Management Service API
    "container.googleapis.com", # Kubernetes Engine API
    "gmail.googleapis.com"      # Gmail API
  ]
}

resource "google_project_service" "project_services" {
  for_each                   = toset(local.enable_apis)
  service                    = each.value
  disable_dependent_services = true
}