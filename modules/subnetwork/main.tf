data "google_compute_network" "compute_network" {
  name = var.google_compute_network_name
}

resource "google_compute_subnetwork" "compute_subnetwork" {
  
  name          = var.google_compute_subnetwork_name
  description   = "${var.google_compute_subnetwork_description} (Created by terraform)"
  ip_cidr_range = var.google_compute_subnetwork_ip_cidr_range
  region        = var.region
  network       = data.google_compute_network.compute_network.id
  
  dynamic "secondary_ip_range" {
    for_each = var.google_compute_subnetwork_secondary_ip_range
    content {
      range_name    = secondary_ip_range.value["range_name"]
      ip_cidr_range = secondary_ip_range.value["ip_cidr_range"]
    }
  }
}