resource "google_storage_bucket" "terraform-state" {
  for_each = toset(["shinji-nishioka-test", "akashi-rb", "hoge-nishioka-tesst"])
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