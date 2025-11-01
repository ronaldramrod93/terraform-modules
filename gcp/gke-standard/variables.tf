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

variable "google_container_cluster_networking_mode" {
  type = string
  description = "Cluster networking mode"
  default = "VPC_NATIVE"
  validation {
    condition = contains(["VPC_NATIVE", "ROUTES"], var.google_container_cluster_networking_mode)
    error_message = "Networking mode must be either VPC_NATIVE or ROUTES"
  }
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

variable "google_container_cluster_master_authorized_networks_config_cidr_blocks" {
  type = list(object({
    cidr_block = string
    display_name = string
  }))
  description = "CIDR blocks authorized for communication to the control plane"
  default = []
}

variable "google_container_cluster_ip_allocation_policy_cluster_secondary_range_name" {
  type = string
  description = "Name of the secondary range name used for pod IP addresses"
}

variable "google_container_cluster_ip_allocation_policy_services_secondary_range_name" {
  type = string
  description = "Name of the secondary range name for service IP addresses"
}

variable "google_container_cluster_default_max_pods_per_node" {
  type = number
  description = "Maximum number of pods per node in the cluster"
  default = 32
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

variable "google_container_cluster_datapath_provider" {
  type = string
  description = "Datapath provider for the GKE cluster"
  default = "ADVANCED_DATAPATH"
  validation {
    condition = contains(["LEGACY_DATAPATH", "ADVANCED_DATAPATH"], var.google_container_cluster_datapath_provider)
    error_message = "Datapath provider must be either LEGACY_DATAPATH or ADVANCED_DATAPATH"
  }
}

variable "google_container_cluster_control_plane_endpoints_config_dns_endpoint_config_allow_external_traffic" {
  type = bool
  description = "Allow external traffic to the control plane DNS endpoint"
  default = true
}

variable "google_container_node_pool_node_count" {
  type = number
  description = "The number of nodes per instance group"
}

variable "google_container_node_pool_preemptible" {
  type = bool
  description = "Enable the utilization of preemptible VM instances"
}

variable "google_container_node_pool_machine_type" {
  type = string
  description = "the name of Google Compute Engine machine type"
}
