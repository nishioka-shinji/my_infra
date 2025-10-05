data "terraform_remote_state" "digger_workload_identity_pool_principal_set" {
  backend = "gcs"
  config = {
    bucket = "shinji-nishioka-test-terraform-state"
    prefix = "terraform/gcp/03-iam"
  }
}