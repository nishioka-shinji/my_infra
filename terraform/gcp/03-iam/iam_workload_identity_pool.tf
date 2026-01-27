locals {
  github_owners = {
    "akashi-rb"       = "AKASHI-rb"
    "nishioka-shinji" = "nishioka-shinji"
  }
}

resource "google_iam_workload_identity_pool" "github" {
  workload_identity_pool_id = "github-pool"
}

resource "google_iam_workload_identity_pool_provider" "github_owners" {
  for_each = local.github_owners

  workload_identity_pool_id          = google_iam_workload_identity_pool.github.workload_identity_pool_id
  workload_identity_pool_provider_id = "${each.key}-prvdr"
  display_name                       = "${each.key}-prvdr"
  attribute_condition                = "attribute.repository_owner == \"${each.value}\""
  attribute_mapping = {
    "google.subject"             = "assertion.sub"
    "attribute.actor"            = "assertion.actor"
    "attribute.aud"              = "assertion.aud"
    "attribute.repository"       = "assertion.repository"
    "attribute.repository_owner" = "assertion.repository_owner"
  }
  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
}
