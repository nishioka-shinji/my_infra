resource "cloudflare_zero_trust_tunnel_cloudflared" "this" {
  account_id = local.account_id
  name       = "ke-zero-cost-tunnel"
  config_src = "cloudflare"
}

resource "cloudflare_zero_trust_tunnel_cloudflared_config" "this" {
  account_id = local.account_id
  tunnel_id  = cloudflare_zero_trust_tunnel_cloudflared.this.id
  config = {
    ingress = [
      {
        hostname       = "*.muso-lab.dev"
        origin_request = {}
        service        = "http://istio-ingress-gateway-istio.istio-ingress.svc.cluster.local"
      },
      {
        service = "http_status:404"
      },
    ]
  }
}
