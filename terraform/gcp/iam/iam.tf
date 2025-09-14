data "terraform_remote_state" "kms" {
  backend = "gcs"
  config = {
    bucket = "shinji-nishioka-test-terraform-state"
    prefix = "terraform/gcp/02-kms"
  }
}

resource "google_service_account" "flux_sops_decryptor" {
  account_id   = "flux-sops-decryptor"
  display_name = "Flux SOPS Decryptor"
}

resource "google_kms_crypto_key_iam_member" "flux_sops_decryptor" {
  crypto_key_id = data.terraform_remote_state.kms.outputs.sops_key_id
  role          = "roles/cloudkms.cryptoKeyDecrypter"
  member        = "serviceAccount:${google_service_account.flux_sops_decryptor.email}"
}
