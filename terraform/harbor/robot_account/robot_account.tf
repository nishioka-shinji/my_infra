resource "harbor_robot_account" "github-actions-pusher" {
  name   = "github-actions-pusher"
  level  = "system"
  permissions {
    kind      = "project"
    namespace = data.terraform_remote_state.my_project.outputs.project_name
    access {
      action   = "pull"
      resource = "repository"
    }
    access {
      action   = "push"
      resource = "repository"
    }
  }
}

resource "harbor_robot_account" "k8s-puller" {
  name   = "k8s-puller"
  level  = "system"
  permissions {
    kind      = "project"
    namespace = data.terraform_remote_state.my_project.outputs.project_name
    access {
      action   = "pull"
      resource = "repository"
    }
  }
}
