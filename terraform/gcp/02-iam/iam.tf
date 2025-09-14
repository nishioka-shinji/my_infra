resource "google_service_account" "flux_sops_decryptor" {
  account_id   = "flux-sops-decryptor"
  display_name = "Flux SOPS Decryptor"
}
