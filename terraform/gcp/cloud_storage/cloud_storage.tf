resource "google_storage_bucket" "terraform-state" {
  for_each = locals.terraform_projects
  name     = "${each.key}-terraform-state"
  location = "asia-northeast2"

  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"

  versioning {
    enabled = true
  }
}

resource "google_storage_bucket_iam_binding" "this" {
  for_each = locals.terraform_projects

  bucket  = google_storage_bucket.terraform-state[each.key].name
  role    = "roles/storage.objectAdmin"
  members = each.value.member
}