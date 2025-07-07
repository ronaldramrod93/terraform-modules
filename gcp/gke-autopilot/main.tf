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

  # The name or self_link of the Google Compute Engine network to which the cluster is connected
  network = data.google_compute_subnetwork.gke_subnet.network
  # The name or self_link of the Google Compute Engine subnetwork in which the cluster's instances are launched.
  subnetwork = data.google_compute_subnetwork.gke_subnet.self_link

  private_cluster_config {
    enable_private_nodes = var.google_container_cluster_private_cluster_config_enable_private_nodes
    # Best-practice: https://cloud.google.com/kubernetes-engine/docs/best-practices/networking#minimize-control-plane-exposure
    enable_private_endpoint = var.google_container_cluster_private_cluster_config_enable_private_endpoint
    #master_ipv4_cidr_block = var.google_container_cluster_private_cluster_config_master_ipv4_cidr_block
  }

  ip_allocation_policy {
    cluster_secondary_range_name = var.google_container_cluster_ip_allocation_policy_cluster_secondary_range_name
    services_secondary_range_name = var.google_container_cluster_ip_allocation_policy_services_secondary_range_name
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }


  # Release channel
  release_channel {
    channel = "REGULAR"
  }

  # Vertical Pod Autoscaling
  vertical_pod_autoscaling {
    enabled = true
  }

  # Best-practice: https://cloud.google.com/kubernetes-engine/docs/best-practices/networking#minimize-control-plane-exposure
  # Use only the DNS-based endpoint to access your control plane for simplified configuration and a flexible and policy-based layer of security.
  control_plane_endpoints_config {
    dns_endpoint_config {
      allow_external_traffic = var.google_container_cluster_control_plane_endpoints_config_dns_endpoint_config_allow_external_traffic
    }
  }

  # Deletion protection prevents the accidental deletion of your cluster.
  deletion_protection = var.google_container_cluster_deletion_protection

  # Logging and monitoring
  logging_config {
    enable_components = ["SYSTEM_COMPONENTS", "WORKLOADS"]
  }

  monitoring_config {
    enable_components = ["SYSTEM_COMPONENTS"]
    managed_prometheus {
      enabled = true
    }
  }

}