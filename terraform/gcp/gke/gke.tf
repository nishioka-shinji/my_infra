resource "google_container_cluster" "primary" {
  name = "my-autopilot-cluster"
  enable_autopilot = true
}