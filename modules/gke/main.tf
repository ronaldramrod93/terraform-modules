# Get the service account email
data "google_service_account" "gke_sa" {
  account_id = var.google_service_account_account_id
}

resource "google_container_cluster" "container_cluster" {
  name     = var.google_container_cluster_name
  
  location = var.region
  
  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  # Best-practice: Use VPC-native cluster for using alias IP address range. 
  # Refer to https://cloud.google.com/kubernetes-engine/docs/best-practices/networking#vpc-native-clusters for more details. 
  networking_mode = "VPC_NATIVE"

  
  private_cluster_config {
    enable_private_nodes = true
    enable_private_endpoint = true
    master_ipv4_cidr_block = "TBD"
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  # ONLY should be uncomment when the deletion of cluster is required
  # deletion_protection = false
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "${var.google_container_cluster_name}-node-pool"

  location   = var.region
  cluster    = google_container_cluster.container_cluster.name
  node_count = 1

  node_config {
    # Use preemptible for saving cost reasons
    preemptible  = true
    
    # minimum machine type in order to install Anthos Service Mesh 
    machine_type = "e2-standard-4"

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = data.google_service_account.gke_sa.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}