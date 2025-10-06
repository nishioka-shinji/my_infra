locals {
  # Atlantis用のサービスアカウントメンバー定義
  atlantis_terraform_executer_sa = "serviceAccount:${google_service_account.this["atlantis-terraform-executer"].email}"

  # IAMロールバインディング定義
  iam_bindings = {
    atlantis = {
      role   = "roles/owner"
      member = local.atlantis_terraform_executer_sa
    }
    gke = {
      role   = "roles/logging.logWriter"
      member = "serviceAccount:513283484243-compute@developer.gserviceaccount.com"
    }
  }
}

resource "google_project_iam_member" "this" {
  for_each = local.iam_bindings

  project = data.google_project.project.id
  role    = each.value.role
  member  = each.value.member
}