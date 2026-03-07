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

import {
  id = "bc9c37d6196f46fd1a5d9099401de6d2"
  to = cloudflare_zone.this["nishiokatest.xyz"]
}

import {
  id = "82c98afccbbee339eeb51823a7051161"
  to = cloudflare_zone.this["muso-lab.dev"]
}
