resource "cloudflare_zone" "this" {
  for_each = toset([
    "nishiokatest.xyz",
    "muso-lab.dev"
  ])

  name = each.value
  account = {
    id = local.account_id
  }
}
