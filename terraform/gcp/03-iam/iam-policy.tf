resource "google_service_account_iam_member" "flux_sops_decryptor" {
  service_account_id = google_service_account.flux_sops_decryptor.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${data.google_client_config.default.project}.svc.id.goog[flux-system/kustomize-controller]"
}
