resource "cloudflare_dns_record" "nishiokatest_xyz" {
  zone_id = cloudflare_zone.this["nishiokatest.xyz"].id
  name    = "*.nishiokatest.xyz"
  type    = "CNAME"
  content = "${cloudflare_zero_trust_tunnel_cloudflared.this.id}.cfargotunnel.com"
  ttl     = 1
  proxied = true
}

resource "cloudflare_dns_record" "muso_lab_dev" {
  zone_id = cloudflare_zone.this["muso-lab.dev"].id
  name    = "*.muso-lab.dev"
  type    = "CNAME"
  content = "${cloudflare_zero_trust_tunnel_cloudflared.this.id}.cfargotunnel.com"
  ttl     = 1
  proxied = true
}
