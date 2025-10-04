locals {
  google_service_account = {
    flux-sops-decryptor = {
      account_id   = "flux-sops-decryptor"
      display_name = "Flux SOPS Decryptor"
      member       = "serviceAccount:shinji-nishioka-test.svc.id.goog[flux-system/kustomize-controller]"
    },
    atlantis-terraform-executer = {
      account_id   = "atlantis-terraform-executer"
      display_name = "Atlantis Terraform Executer"
      member       = "serviceAccount:shinji-nishioka-test.svc.id.goog[atlantis/atlantis]"
    },
    digger-terraform-executer = {
      account_id   = "digger-terraform-executer"
      display_name = "Digger Terraform Executer"
      member       = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.digger.name}/attribute.repository/AKASHI-rb/akashi-rb-infra"
    }
  }
}

resource "google_service_account" "this" {
  for_each = local.google_service_account

  account_id   = each.value.account_id
  display_name = each.value.display_name
}

resource "google_service_account_iam_member" "this" {
  for_each = local.google_service_account

  service_account_id = google_service_account.this[each.key].name
  role               = "roles/iam.workloadIdentityUser"
  member             = each.value.member
}
