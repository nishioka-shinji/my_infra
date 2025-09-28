resource "harbor_robot_account" "github-actions-pusher" {
  name   = "github-actions-pusher"
  level  = "system"
  permissions {
    kind      = "project"
    namespace = data.harbor_project.my_project.name
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