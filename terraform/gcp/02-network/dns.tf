resource "google_dns_managed_zone" "nishioka_test_zone" {
  name        = "nishioka-test-zone"
  dns_name    = "nishiokatest.xyz."
  description = "Managed zone for nishiokatest.xyz"
}
