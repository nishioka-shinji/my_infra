resource "google_storage_bucket" "terraform-state" {
  name     = "shinji-nishioka-test-terraform-state"
  location = "asia-northeast2"

  versioning {
    enabled = true
  }
}
