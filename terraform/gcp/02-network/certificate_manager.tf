# Terraform configuration for Google Cloud Certificate Manager resources

resource "google_certificate_manager_dns_authorization" "nishiokatest_dns_auth" {
  name        = "nishiokatest-dns-auth"
  domain      = "nishiokatest.xyz"
  description = "DNS Authorization for nishiokatest.xyz"
}

resource "google_certificate_manager_certificate" "nishiokatest_wildcard_cert" {
  name        = "nishiokatest-wildcard-cert"
  description = "Wildcard certificate for nishiokatest.xyz"
  managed {
    domains = ["*.nishiokatest.xyz"]
    dns_authorizations = [
      google_certificate_manager_dns_authorization.nishiokatest_dns_auth.id
    ]
  }
}

resource "google_certificate_manager_certificate_map" "nishiokatest_cert_map" {
  name        = "nishiokatest-cert-map"
  description = "Certificate map for nishiokatest.xyz"
}

resource "google_certificate_manager_certificate_map_entry" "nishiokatest_cert_map_entry" {
  name     = "nishiokatest-cert-map-entry"
  map      = google_certificate_manager_certificate_map.nishiokatest_cert_map.name
  hostname = "*.nishiokatest.xyz"
  certificates = [
    google_certificate_manager_certificate.nishiokatest_wildcard_cert.id
  ]
}
