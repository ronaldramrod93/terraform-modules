# Get the subnet information
data "google_compute_subnetwork" "gke_subnet" {
  name = var.google_container_cluster_subnetwork
}

# Get the service account email
data "google_service_account" "gke_sa" {
  account_id = var.google_service_account_account_id
}

resource "google_container_cluster" "container_cluster" {
  name     = var.google_container_cluster_name

  enable_autopilot = var.google_container_cluster_enable_autopilot
  
  # Best-practice: https://cloud.google.com/kubernetes-engine/docs/best-practices/networking#use-regional-clusters-distribute-workloads
  location = var.region
  
  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  # The name or self_link of the Google Compute Engine network to which the cluster is connected
  network = data.google_compute_subnetwork.gke_subnet.network
  # The name or self_link of the Google Compute Engine subnetwork in which the cluster's instances are launched.
  subnetwork = data.google_compute_subnetwork.gke_subnet.self_link

  # For clusters created in the Autopilot mode, VPC-native mode is always on and cannot be turned off.
  networking_mode = var.google_container_cluster_networking_mode

  private_cluster_config {
    enable_private_nodes = var.google_container_cluster_private_cluster_config_enable_private_nodes
    # Best-practice: https://cloud.google.com/kubernetes-engine/docs/best-practices/networking#minimize-control-plane-exposure
    enable_private_endpoint = var.google_container_cluster_private_cluster_config_enable_private_endpoint
    #master_ipv4_cidr_block = var.google_container_cluster_private_cluster_config_master_ipv4_cidr_block
  }

  master_authorized_networks_config {
    dynamic "cidr_blocks" {
      for_each = var.google_container_cluster_master_authorized_networks_config_cidr_blocks
      content {
        cidr_block = cidr_blocks.value["cidr_block"]
        display_name = cidr_blocks.value["display_name"]
      }
    }
  }

  ip_allocation_policy {
    cluster_secondary_range_name = var.google_container_cluster_ip_allocation_policy_cluster_secondary_range_name
    services_secondary_range_name = var.google_container_cluster_ip_allocation_policy_services_secondary_range_name
  }

  default_max_pods_per_node = var.google_container_cluster_default_max_pods_per_node

  network_policy {
    enabled = var.google_container_cluster_network_policy_enabled
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  # Best-practice: https://cloud.google.com/kubernetes-engine/docs/best-practices/networking#minimize-control-plane-exposure
  # Use only the DNS-based endpoint to access your control plane for simplified configuration and a flexible and policy-based layer of security.
  control_plane_endpoints_config {
    dns_endpoint_config {
      allow_external_traffic = var.google_container_cluster_control_plane_endpoints_config_dns_endpoint_config_allow_external_traffic
    }
  }

  # Best-practice: https://cloud.google.com/kubernetes-engine/docs/best-practices/networking#dataplane-v2
  # GKE Dataplane V2 provides an integrated network security and visibility experience.
  datapath_provider = var.google_container_cluster_datapath_provider

  # Deletion protection prevents the accidental deletion of your cluster.
  deletion_protection = var.google_container_cluster_deletion_protection
}

resource "google_container_node_pool" "container_node_pool" {
  name       = "${var.google_container_cluster_name}-node-pool"

  location   = var.region
  cluster    = google_container_cluster.container_cluster.name
  
  node_count = var.google_container_node_pool_node_count

  node_config {
    # Use preemptible for saving cost reasons
    preemptible  = var.google_container_node_pool_preemptible #true
    
    # minimum machine type in order to install Anthos Service Mesh 
    machine_type = var.google_container_node_pool_machine_type #"e2-standard-4"

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = data.google_service_account.gke_sa.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}