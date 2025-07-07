variable "project_id" {
    type = string
    description = "GCP Project ID"
}

variable "region" {
    type = string
    description = "GCP region"
}

variable "google_container_cluster_name" {
  type = string
  description = "Google container cluster name"
}

variable "google_service_account_account_id" {
  type = string
  description = "Google service account ID"
}

variable "google_container_cluster_subnetwork" {
  type = string
  description = "Cluster subnetwork name"
}

variable "google_container_cluster_private_cluster_config_enable_private_nodes" {
  type = bool
  description = "Enable private cluster feature, nodes only have private IP addresses"
}

variable "google_container_cluster_private_cluster_config_enable_private_endpoint" {
  type = bool
  description = "The IP address used by the control plane will only be private"
}

variable "google_container_cluster_private_cluster_config_master_ipv4_cidr_block" {
  type = string
  description = "IP address range used by the control plane"
}

variable "google_container_cluster_ip_allocation_policy_cluster_secondary_range_name" {
  type = string
  description = "Name of the secondary range name used for pod IP addresses"
}

variable "google_container_cluster_ip_allocation_policy_services_secondary_range_name" {
  type = string
  description = "Name of the secondary range name for service IP addresses"
}

variable "google_container_cluster_network_policy_enabled" {
  type = bool
  description = "Enable the network policy"
}

variable "google_container_cluster_deletion_protection" {
  type = bool
  description = "Enable deletion protection"
  default = true
}

variable "google_container_cluster_enable_autopilot" {
  type = bool
  description = "Enable Autopilot mode for the GKE cluster"
  default = false
}

variable "google_container_cluster_control_plane_endpoints_config_dns_endpoint_config_allow_external_traffic" {
  type = bool
  description = "Allow external traffic to the control plane DNS endpoint"
  default = true
}