resource "kubernetes_service_account" "flux_sops_decryptor" {
  metadata {
    name      = "kustomize-controller"
    namespace = "flux-system"
    annotations = {
      "iam.gke.io/gcp-service-account" = google_service_account.flux_sops_decryptor.email
    }
  }
}
