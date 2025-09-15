data "google_project" "project" {}

data "terraform_remote_state" "iam" {
  backend = "gcs"
  config = {
    bucket = "shinji-nishioka-test-terraform-state"
    prefix = "terraform/gcp/03-iam"
  }
}
