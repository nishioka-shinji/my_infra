locals {
  # Atlantis用のサービスアカウントメンバー定義
  atlantis_terraform_executer_sa = "serviceAccount:${google_service_account.this["atlantis-terraform-executer"].email}"
  # digger用のサービスアカウントメンバー定義
  digger_terraform_executer_sa = "serviceAccount:${google_service_account.this["digger-terraform-executer"].email}"

  # IAMロールバインディング定義
  iam_bindings = {
    atlantis = {
      role   = "roles/owner"
      member = local.atlantis_terraform_executer_sa
    }
    digger-gcs-user = {
      role   = "roles/storage.objectUser"
      member = local.digger_terraform_executer_sa
    }
  }
}

resource "google_project_iam_member" "this" {
  for_each = local.iam_bindings

  project = data.google_project.project.id
  role    = each.value.role
  member  = each.value.member
}