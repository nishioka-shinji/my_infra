output "flux_sops_decryptor_email" {
  description = "The email of the service account used by Flux for SOPS decryption."
  value       = google_service_account.this["flux-sops-decryptor"].email
}

output "digger_workload_identity_pool_principal_set" {
  description = "The principal set for the Digger workload identity pool."
  value       = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.digger.name}/attribute.repository/${local.github_repository}"
}
