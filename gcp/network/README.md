# Compute Network Terraform Module

This module is responsible for creating and managing Google Compute Network resources.

## Prerequisite
- Enable Compute Engine API, use the below command:
```bash
gcloud services enable compute.googleapis.com --project YOUR_PROJECT_ID
```
## Usage

### Using with Terragrunt

In order to use this module with terragrunt, please refer to [here](https://github.com/ronaldramrod93/terragrunt-modules/tree/main/gcp/network) where you will find real examples.

### Using with Terraform module

If you prefer only to use terraform, here is a basic example of how to use this module:

```hcl
module "network" {
    source = "git::https://github.com/ronaldramrod93/terraform-modules.git//gcp/network?ref=main"
    
    google_compute_network_name = "net-demo"
    google_compute_network_description = "Network created by testing"
    
    # Best-practice: https://cloud.google.com/kubernetes-engine/docs/best-practices/networking#custom-subnet-mode
    google_compute_network_auto_create_subnetworks = false
    
    google_compute_network_routing_mode = "REGIONAL"

}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | 5.13.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 5.13.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_network.compute_network](https://registry.terraform.io/providers/hashicorp/google/5.13.0/docs/resources/compute_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_google_compute_network_auto_create_subnetworks"></a> [google\_compute\_network\_auto\_create\_subnetworks](#input\_google\_compute\_network\_auto\_create\_subnetworks) | Enable auto creation of subnetworks | `bool` | n/a | yes |
| <a name="input_google_compute_network_description"></a> [google\_compute\_network\_description](#input\_google\_compute\_network\_description) | Compute network description | `string` | n/a | yes |
| <a name="input_google_compute_network_name"></a> [google\_compute\_network\_name](#input\_google\_compute\_network\_name) | Compute network name | `string` | n/a | yes |
| <a name="input_google_compute_network_routing_mode"></a> [google\_compute\_network\_routing\_mode](#input\_google\_compute\_network\_routing\_mode) | Routing mode. Possible values [REGIONAL, GLOBAL] | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | GCP Project ID | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | GCP region | `string` | n/a | yes |

## Outputs

No outputs.
