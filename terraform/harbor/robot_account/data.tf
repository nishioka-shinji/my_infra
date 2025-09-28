data "terraform_remote_state" "my_project" {
  backend = "gcs"
  config = {
    bucket = "shinji-nishioka-test-terraform-state"
    prefix = "terraform/harbor/01-projects"
  }
}