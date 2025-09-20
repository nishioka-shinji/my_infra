output "flux_sops_decryptor_email" {
  description = "The email of the service account used by Flux for SOPS decryption."
  value       = google_service_account.this["flux-sops-decryptor"].email
}

output "atlantis-terraform-executer" {
  description = "The email of the service account used by Atlantis for Terraform execution."
  value       = google_service_account.this["atlantis-terraform-executer"].email
}