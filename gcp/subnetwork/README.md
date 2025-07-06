# Compute Subnetwork Terraform Module

This is the `compute subnetwork` module of the `terraform-modules` project. This module is responsible for creating and managing Google Compute Subnetwork resources.

# Prerequisite
- The service account used must have the role: `roles/compute.networkAdmin`

## Usage

### Using Terragrunt module

In order to use this module with terragrunt, please refer to https://github.com/ronaldramrod93/terragrunt-modules/tree/main/gcp/subnetwork, where you will find real examples.

### Using Terraform module

If you only want use terraform, here is a basic example of how to use this module:

```hcl
module "subnetwork" {
  source = "git::https://github.com/ronaldramrod93/terraform-modules.git//modules/subnetwork?ref=main"
  
  # Prerequisite: The compute network must already be created
  google_compute_network_name = "net-demo"

  google_compute_subnetwork_name = "gke-nodes-1"
  google_compute_subnetwork_description = "Subnet used by nodes in GKE cluster"
  
  # Best-practice: https://cloud.google.com/kubernetes-engine/docs/best-practices/networking#use-private-google-access
  google_compute_subnetwork_private_ip_google_access = true
  
  # Best-practice: https://cloud.google.com/kubernetes-engine/docs/best-practices/networking#plan-ip-allotment
  # For private clusters, you must define a node subnet, a Pod IP address range, and a Service IP address range.
  google_compute_subnetwork_ip_cidr_range = "10.1.0.0/28"
  
  # The Pod and Service IP address range always will be defined as secondary IP ranges
  google_compute_subnetwork_secondary_ip_range = [
    {
      range_name = "gke-pods-1"
      ip_cidr_range = "10.2.0.0/25"
    },
    {
      range_name = "gke-services-1"
      ip_cidr_range = "10.2.2.0/27"
    }
  ]
}
```

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 6.27.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_subnetwork.compute_subnetwork](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork) | resource |
| [google_compute_network.compute_network](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_google_compute_network_name"></a> [google\_compute\_network\_name](#input\_google\_compute\_network\_name) | Compute network name | `string` | n/a | yes |
| <a name="input_google_compute_subnetwork_description"></a> [google\_compute\_subnetwork\_description](#input\_google\_compute\_subnetwork\_description) | Compute subnetwork description | `string` | n/a | yes |
| <a name="input_google_compute_subnetwork_ip_cidr_range"></a> [google\_compute\_subnetwork\_ip\_cidr\_range](#input\_google\_compute\_subnetwork\_ip\_cidr\_range) | Primary IP CIDR range in subnetwork | `string` | n/a | yes |
| <a name="input_google_compute_subnetwork_name"></a> [google\_compute\_subnetwork\_name](#input\_google\_compute\_subnetwork\_name) | Compute subnetwork name | `string` | n/a | yes |
| <a name="input_google_compute_subnetwork_private_ip_google_access"></a> [google\_compute\_subnetwork\_private\_ip\_google\_access](#input\_google\_compute\_subnetwork\_private\_ip\_google\_access) | Enable access to google APIs only for internal IP addresses | `bool` | n/a | yes |
| <a name="input_google_compute_subnetwork_secondary_ip_range"></a> [google\_compute\_subnetwork\_secondary\_ip\_range](#input\_google\_compute\_subnetwork\_secondary\_ip\_range) | Secondary IP range in subnetwork | <pre>list(object({<br>    range_name = string<br>    ip_cidr_range = string<br>  }))</pre> | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | GCP Project ID | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | GCP region | `string` | n/a | yes |

## Outputs

No outputs.
