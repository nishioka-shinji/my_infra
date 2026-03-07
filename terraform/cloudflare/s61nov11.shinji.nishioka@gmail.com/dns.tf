resource "cloudflare_dns_record" "nishiokatest_xyz" {
  zone_id = cloudflare_zone.this["nishiokatest.xyz"].id
  name    = "*.nishiokatest.xyz"
  type    = "CNAME"
  content = "${cloudflare_zero_trust_tunnel_cloudflared.this.id}.cfargotunnel.com"
  ttl     = 1
  proxied = true
}

import {
  id = "${cloudflare_zone.this["nishiokatest.xyz"].id}/d1f4729d5b48668ac17965584573c521"
  to = cloudflare_dns_record.nishiokatest_xyz
}