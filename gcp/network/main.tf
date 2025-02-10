resource "google_compute_network" "compute_network" {
  
  name                    = var.google_compute_network_name
  description             = "${var.google_compute_network_description} (Created by terraform)"
  auto_create_subnetworks = var.google_compute_network_auto_create_subnetworks
  routing_mode            = var.google_compute_network_routing_mode

}