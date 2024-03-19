# GKE terraform module

This is the `gke` module of the `roka_pf_tf-modules` project. This module is responsible for creating and managing Google Kubernetes Engine (GKE) resources.

# Pre requisite
- Create a network. Refer to this [network tf module](https://github.com/ronaldramrod93/roka_pf_tf-modules/tree/main/modules/network)
- Create a subnetwork (primary and secondary IP address ranges). Refer to this [subnet tf module](https://github.com/ronaldramrod93/roka_pf_tf-modules/tree/main/modules/subnetwork)
- Enable the follow API in the GCP project:
  - Compute Engine API
  - Kubernetes Engine API
- Create a Service Account for the terraform execution. Refer to this [IAM SA module](https://github.com/ronaldramrod93/roka_pf_tf-modules/tree/main/modules/service-account)

## Usage

### Using Terragrunt module

In order to use this module with terragrunt, please refer to https://github.com/ronaldramrod93/roka_pf_tg-modules/tree/main/gke, where you will find real examples.

### Using Terraform module

If you only want use terraform, here is a basic example of how to use this module:


```hcl
module "gke" {
    source = "git::https://github.com/ronaldramrod93/roka_pf_tf-modules.git//modules/gke?ref=main"

    google_container_cluster_name = "portfolio"
    google_service_account_account_id = "gke-sa"

    google_container_cluster_subnetwork = "gke-nodes-1"

    # Best-practice: Use VPC-native cluster for using alias IP address range. 
    # Refer to https://cloud.google.com/kubernetes-engine/docs/best-practices/networking#vpc-native-clusters for more details. 
    google_container_cluster_networking_mode = "VPC_NATIVE"

    # Best-practice: https://cloud.google.com/kubernetes-engine/docs/best-practices/networking#private-cluster-type
    google_container_cluster_private_cluster_config_enable_private_nodes = true

    google_container_cluster_private_cluster_config_enable_private_endpoint = false
    google_container_cluster_private_cluster_config_master_ipv4_cidr_block = "172.16.0.32/28"

    google_container_cluster_master_authorized_networks_config_cidr_blocks = [
      {
        cidr_block = "34.138.83.224/32"
        display_name = "Cloud shell IP address"
      }
    ]

    # Best-practice: https://cloud.google.com/kubernetes-engine/docs/best-practices/networking#plan-ip-allotment
    # For private clusters, you must define a node subnet, a Pod IP address range, and a Service IP address range.
    google_container_cluster_ip_allocation_policy_cluster_secondary_range_name = "gke-pods-1"
    google_container_cluster_ip_allocation_policy_services_secondary_range_name = "gke-services-1" 

    google_container_cluster_default_max_pods_per_node = 16

    # Best-practice: https://cloud.google.com/kubernetes-engine/docs/best-practices/networking#restrict-traffic-network-pols
    # GKE network policies are configured through the Kubernetes Network Policy API to enforce a cluster's Pod communication.
    google_container_cluster_network_policy_enabled = true

    google_container_node_pool_node_count = 1

    google_container_node_pool_preemptible = true

    google_container_node_pool_machine_type = "e2-standard-4"

    google_container_cluster_deletion_protection = false
}
```
