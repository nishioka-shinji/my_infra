resource "google_dns_managed_zone" "akashi_rb_zone" {
  name        = "akashi-rb-zone"
  dns_name    = "akashi-rb.com."
  description = "Managed zone for akashi-rb.com"
}
