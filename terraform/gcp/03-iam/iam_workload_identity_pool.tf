# resource "google_iam_workload_identity_pool" "digger" {
#   workload_identity_pool_id = "digger-pool"
# }
#
# resource "google_iam_workload_identity_pool_provider" "digger" {
#   workload_identity_pool_id          = google_iam_workload_identity_pool.digger.workload_identity_pool_id
#   workload_identity_pool_provider_id = "digger-prvdr"
#   display_name                       = "digger-prvdr"
#   attribute_condition                = "attribute.repository == \"AKASHI-rb/akashi-rb-infra\""
#   attribute_mapping = {
#     "google.subject"       = "assertion.sub"
#     "attribute.actor"      = "assertion.actor"
#     "attribute.aud"        = "assertion.aud"
#     "attribute.repository" = "assertion.repository"
#   }
#   oidc {
#     issuer_uri = "https://token.actions.githubusercontent.com"
#   }
# }