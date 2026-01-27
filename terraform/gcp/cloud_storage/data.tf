data "terraform_remote_state" "akashi_rb_infra_principal_set" {
  backend = "gcs"
  config = {
    bucket = "shinji-nishioka-test-terraform-state"
    prefix = "terraform/gcp/03-iam"
  }
}