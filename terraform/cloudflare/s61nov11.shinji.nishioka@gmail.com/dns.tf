resource "cloudflare_dns_record" "nishiokatest_xyz" {
  zone_id = cloudflare_zone.this["nishiokatest.xyz"].id
  name    = "*.nishiokatest.xyz"
  type    = "CNAME"
  content = "90137deb-48e6-44f7-a59c-77b4da2117e9.cfargotunnel.com"
  ttl     = 1
  proxied = true
}

import {
  id = "${cloudflare_zone.this["nishiokatest.xyz"].id}/d1f4729d5b48668ac17965584573c521"
  to = cloudflare_dns_record.nishiokatest_xyz
}