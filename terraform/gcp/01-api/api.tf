locals {
  enable_apis = [
    "admin.googleapis.com",              # Admin SDK API
    "certificatemanager.googleapis.com", # Certificate Manager API
    "cloudaicompanion.googleapis.com",   # Gemini for Google Cloud API
    "cloudkms.googleapis.com",           # Cloud Key Management Service API
    "container.googleapis.com",          # Kubernetes Engine API
    "geminicloudassist.googleapis.com",  # Gemini Cloud Assist API
    "gmail.googleapis.com",              # Gmail API
    "iam.googleapis.com",                # Identity and Access Management (IAM) API
    "logging.googleapis.com",            # Cloud Logging API
    "serviceusage.googleapis.com",       # Service Usage API
    "sts.googleapis.com"                 # Security Token Service API
  ]
}

resource "google_project_service" "project_services" {
  for_each                   = toset(local.enable_apis)
  service                    = each.value
  disable_dependent_services = true
}