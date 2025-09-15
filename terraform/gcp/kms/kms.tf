resource "google_kms_key_ring" "sops" {
  name     = "sops"
  location = "asia-northeast2"
}

resource "google_kms_crypto_key" "sops_key" {
  name     = "sops-key"
  key_ring = google_kms_key_ring.sops.id

  lifecycle {
    prevent_destroy = true
  }
}

resource "google_kms_crypto_key_iam_member" "sops_user" {
  crypto_key_id = google_kms_crypto_key.sops_key.id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member        = "user:s61nov11.shinji.nishioka@gmail.com"
}

resource "google_kms_crypto_key_iam_member" "flux_sops_decryptor" {
  crypto_key_id = google_kms_crypto_key.sops_key.id
  role          = "roles/cloudkms.cryptoKeyDecrypter"
  member        = "principal://iam.googleapis.com/projects/${data.google_project.project.number}/locations/global/workloadIdentityPools/${data.google_project.project.project_id}.svc.id.goog/subject/ns/flux-system/sa/kustomize-controller"
}
