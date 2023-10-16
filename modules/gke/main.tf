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
  
  # Best-practice: https://cloud.google.com/kubernetes-engine/docs/best-practices/networking#use-regional-clusters-distribute-workloads
  location = var.region
  
  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  network = data.google_compute_subnetwork.gke_subnet.network
  subnetwork = data.google_compute_subnetwork.gke_subnet.self_link

  networking_mode = var.google_container_cluster_networking_mode

  # Best-practice: https://cloud.google.com/kubernetes-engine/docs/best-practices/networking#private-cluster-type
  private_cluster_config {
    enable_private_nodes = var.google_container_cluster_private_cluster_config_enable_private_nodes #true
    # Best-practice: https://cloud.google.com/kubernetes-engine/docs/best-practices/networking#minimize-control-plane-exposure
    enable_private_endpoint = var.google_container_cluster_private_cluster_config_enable_private_endpoint #true
    master_ipv4_cidr_block = var.google_container_cluster_private_cluster_config_master_ipv4_cidr_block #"TBD"
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

  # Best-practice: https://cloud.google.com/kubernetes-engine/docs/best-practices/networking#restrict-traffic-network-pols
  network_policy {
    enabled = var.google_container_cluster_network_policy_enabled #true
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  # ONLY should be uncomment when the deletion of cluster is required
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