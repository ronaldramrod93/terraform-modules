# GCS Terraform Module

This is the `gcs` module of the `roka_pf_tf-modules` project. This module is responsible for creating and managing Google Cloud Storage (GCS) resources.

## Usage

### Using Terragrunt module

In order to use this module with terragrunt, please refer to https://github.com/ronaldramrod93/roka_pf_tg-modules/tree/main/gcs, where you will also find real examples.

### Using Terraform module

If you only want use terraform, here is a basic example of how to use this module:

```hcl
module "gcs" {
    source = "git::https://github.com/ronaldramrod93/roka_pf_tf-modules.git//modules/gcs?ref=main"
    
    bucket_name = "bucketname"
    location    = "us-central1"
    enable_versioning = true
    labels = {
        env = "dev"
        purpose = "demo"
    }

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
| [google_storage_bucket.pf-tfstate](https://registry.terraform.io/providers/hashicorp/google/5.13.0/docs/resources/storage_bucket) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | GCS bucket name | `string` | n/a | yes |
| <a name="input_enable_versioning"></a> [enable\_versioning](#input\_enable\_versioning) | enable versioning in GCS | `bool` | `false` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | Enable the force destroy the bucket | `bool` | `false` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Labels to assign on the GCS bucket. | `map(any)` | `{}` | no |
| <a name="input_location"></a> [location](#input\_location) | location of the GCS bucket | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | GCP project ID | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | GCP region | `string` | n/a | yes |
| <a name="input_storage_class"></a> [storage\_class](#input\_storage\_class) | storage class of the GCS bucket | `string` | `"STANDARD"` | no |

## Outputs

No outputs.

## Planned Enhancements

- Implement bucket's **encryption** configuration
- Implement bucket's **lifecycle rules** configuration
- Implement **logging**
- Guide to **create a tfstate bucket**