output "flux_sops_decryptor_email" {
  description = "The email of the service account used by Flux for SOPS decryption."
  value       = google_service_account.flux_sops_decryptor.email
}
