output "flux_sops_decryptor_email" {
  description = "The email of the service account used by Flux for SOPS decryption."
  value       = google_service_account.this["flux-sops-decryptor"].email
}

output "akashi_rb_infra_principal_set" {
  description = "The principal set for the GitHub workload identity pool."
  value       = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.github.name}/attribute.repository/AKASHI-rb/akashi-rb-infra"
}
