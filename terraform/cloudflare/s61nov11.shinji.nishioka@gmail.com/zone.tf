resource "cloudflare_zone" "this" {
  for_each = toset([
    "muso-lab.dev"
  ])

  name = each.value
  account = {
    id = local.account_id
  }
}
