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
        hostname       = "*.akashi-rb.com"
        origin_request = {}
        service        = "http://istio-ingress-gateway-istio.istio-ingress.svc.cluster.local"
      },
      {
        hostname       = "*.nishiokatest.xyz"
        origin_request = {}
        service        = "http://istio-ingress-gateway-istio.istio-ingress.svc.cluster.local"
      },
      {
        service = "http_status:404"
      },
    ]
  }
}

import {
  id = "59e80e25c95fb00ff987a1b8af46bd52/90137deb-48e6-44f7-a59c-77b4da2117e9"
  to = cloudflare_zero_trust_tunnel_cloudflared.this
}

import {
  id = "59e80e25c95fb00ff987a1b8af46bd52/90137deb-48e6-44f7-a59c-77b4da2117e9"
  to = cloudflare_zero_trust_tunnel_cloudflared_config.this
}
