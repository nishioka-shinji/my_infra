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

resource "google_dns_record_set" "nishiokatest_auth_cname" {
  name         = google_certificate_manager_dns_authorization.nishiokatest_dns_auth.dns_resource_record[0].name
  type         = google_certificate_manager_dns_authorization.nishiokatest_dns_auth.dns_resource_record[0].type
  ttl          = 300
  managed_zone = google_dns_managed_zone.nishioka_test_zone.name
  rrdatas = [
    google_certificate_manager_dns_authorization.nishiokatest_dns_auth.dns_resource_record[0].data
  ]
}
