resource "google_project_iam_member" "atlantis-terraform-executer" {
  for_each = toset([
    "roles/editor",
    "roles/resourcemanager.projectIamAdmin",
    "roles/iam.serviceAccountAdmin"
  ])

  project = data.google_project.project.id
  role    = each.value
  member  = "serviceAccount:${google_service_account.this["atlantis-terraform-executer"].email}"
}
