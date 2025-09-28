resource "harbor_project" "my_project" {
  name = "my_project"
}

output "project_name" {
  value = harbor_project.my_project.name
}