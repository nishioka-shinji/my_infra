resource "google_service_account" "flux_sops_decryptor" {
  account_id   = "flux-sops-decryptor"
  display_name = "Flux SOPS Decryptor"
}

resource "google_service_account" "atlantis" {
  account_id   = "atlantis"
  display_name = "Atlantis"
}

resource "google_service_account_iam_member" "atlantis" {
  service_account_id = google_service_account.atlantis.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:shinji-nishioka-test.svc.id.goog[atlantis/atlantis]"
}

resource "google_project_iam_member" "atlantis" {
  project = "shinji-nishioka-test"
  role    = "roles/editor"
  member  = "serviceAccount:${google_service_account.atlantis.email}"
}
