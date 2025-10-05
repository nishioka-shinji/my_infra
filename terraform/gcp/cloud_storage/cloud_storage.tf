resource "google_storage_bucket" "terraform-state" {
  for_each = toset(["shinji-nishioka-test", "akashi-rb"])
  name     = "${each.value}-terraform-state"
  location = "asia-northeast2"

  versioning {
    enabled = true
  }
}

moved {
  from = google_storage_bucket.terraform-state
  to   = google_storage_bucket.terraform-state["shinji-nishioka-test"]
}

resource "google_storage_bucket_iam_member" "editor_access" {
  bucket = google_storage_bucket.terraform-state["akashi-rb"].name
  role   = "roles/storage.objectAdmin"
  member = data.terraform_remote_state.digger_workload_identity_pool_principal_set.outputs.digger_workload_identity_pool_principal_set
}