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
