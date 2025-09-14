resource "google_service_account_iam_member" "flux_sops_decryptor" {
  service_account_id = google_service_account.flux_sops_decryptor.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:shinji-nishioka-test.svc.id.goog[flux-system/kustomize-controller]"
}
