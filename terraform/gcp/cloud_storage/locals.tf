locals {
  terraform_projects = {
    shinji-nishioka-test = {
      member = [
        "user:s61nov11.shinji.nishioka@gmail.com",
        "serviceAccount:atlantis-terraform-executer@shinji-nishioka-test.iam.gserviceaccount.com"
      ]
    }
    akashi-rb = {
      member = [
        "user:s61nov11.shinji.nishioka@gmail.com",
        # AKASHI-rb/akashi-rb-terraformのGithub Actions
        data.terraform_remote_state.akashi_rb_terraform_principal_set.outputs.akashi_rb_terraform_principal_set
      ]
    }
  }
}
