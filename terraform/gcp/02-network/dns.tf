resource "google_dns_managed_zone" "nishioka_test_zone" {
  name        = "nishioka-test-zone"
  dns_name    = "nishiokatest.xyz."
  description = "Managed zone for nishiokatest.xyz"
}

resource "google_compute_global_address" "nishiokatest_ip" {
  name = "nishiokatest-ip"
}

resource "google_dns_record_set" "a_record_wildcard" {
  name         = "*.${google_dns_managed_zone.nishioka_test_zone.dns_name}"
  managed_zone = google_dns_managed_zone.nishioka_test_zone.name
  type         = "A"
  ttl          = 300
  rrdatas      = [google_compute_global_address.nishiokatest_ip.address]
}

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

resource "google_dns_record_set" "nishiokatest_auth_cname" {
  name         = google_certificate_manager_dns_authorization.nishiokatest_dns_auth.dns_resource_record[0].name
  type         = google_certificate_manager_dns_authorization.nishiokatest_dns_auth.dns_resource_record[0].type
  ttl          = 300
  managed_zone = google_dns_managed_zone.nishioka_test_zone.name
  rrdatas = [
    google_certificate_manager_dns_authorization.nishiokatest_dns_auth.dns_resource_record[0].data
  ]
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
