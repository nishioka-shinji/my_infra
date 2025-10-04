locals {
  # Atlantis用のサービスアカウントメンバー定義
  atlantis_terraform_executer_sa = "serviceAccount:${google_service_account.this["atlantis-terraform-executer"].email}"

  # Atlantis用のIAMロールバインディング定義
  atlantis_iam_bindings = [
    {
      name   = "atlantis-editor"
      role   = "roles/editor"
      member = local.atlantis_terraform_executer_sa
    },
    {
      name   = "atlantis-project-iam-admin"
      role   = "roles/resourcemanager.projectIamAdmin"
      member = local.atlantis_terraform_executer_sa
    },
    {
      name   = "atlantis-service-account-admin"
      role   = "roles/iam.serviceAccountAdmin"
      member = local.atlantis_terraform_executer_sa
    }
  ]
}

resource "google_project_iam_member" "this" {
  for_each = { for binding in local.atlantis_iam_bindings : binding.name => binding }

  project = data.google_project.project.id
  role    = each.value.role
  member  = each.value.member
}

moved {
  from = google_project_iam_member.atlantis-terraform-executer["roles/editor"]
  to   = google_project_iam_member.this["atlantis-editor"]
}

moved {
  from = google_project_iam_member.atlantis-terraform-executer["roles/resourcemanager.projectIamAdmin"]
  to   = google_project_iam_member.this["atlantis-project-iam-admin"]
}

moved {
  from = google_project_iam_member.atlantis-terraform-executer["roles/iam.serviceAccountAdmin"]
  to   = google_project_iam_member.this["atlantis-service-account-admin"]
}