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
        # AKASHI-rb/akashi-rb-infraのGithub Actions
        data.terraform_remote_state.digger_workload_identity_pool_principal_set.outputs.digger_workload_identity_pool_principal_set
      ]
    }
  }
}
