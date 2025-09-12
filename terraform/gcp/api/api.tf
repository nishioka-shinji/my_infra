locals {
  enable_apis = [
    "container.googleapis.com" # Kubernetes Engine API
  ]
}

resource "google_project_service" "project_services" {
  for_each                   = toset(local.enable_apis)
  service                    = each.value
  disable_dependent_services = true
}