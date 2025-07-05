# IAM Service account Terraform Module

This is the `service-account` module of the `terraform-modules` project. This module is responsible for creating and managing IAM service account resources.

# Prerequisite
- The service account used must have the below roles: 
  * `roles/iam.serviceAccountAdmin` (Allows creating/deleting service accounts)
  * `roles/iam.serviceAccountUser` (Allows impersonating/binding service accounts)
  * `roles/resourcemanager.projectIamAdmin` (To assign predefined roles at the project level)

## Usage

### Using Terragrunt module

In order to use this module with terragrunt, please refer to https://github.com/ronaldramrod93/terragrunt-modules/tree/main/gcp/service-account, where you will also find real examples.

### Using Terraform module

If you only want use terraform, here is a basic example of how to use this module:

```hcl
module "gcs" {
    source = "git::https://github.com/ronaldramrod93/terraform-modules.git//gcp/service-account?ref=main"

    project_id = "sre-devops-portfolio"
    region     = "us-central1"
    
    google_service_account_account_id = "sa-name"
    google_service_account_display_name = "service account description"
  
    google_project_iam_member = [
      {
        role = "roles/editor"
      }
    ]

    google_service_account_iam_member = [
      {
        role = "roles/iam.serviceAccountTokenCreator"
        member = "user:my-user@gmail.com"
      }
    ]
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | 6.27.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 6.27.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_project_iam_binding.project_iam_binding](https://registry.terraform.io/providers/hashicorp/google/6.27.0/docs/resources/project_iam_binding) | resource |
| [google_project_iam_member.project_iam_member](https://registry.terraform.io/providers/hashicorp/google/6.27.0/docs/resources/project_iam_member) | resource |
| [google_service_account.service_account](https://registry.terraform.io/providers/hashicorp/google/6.27.0/docs/resources/service_account) | resource |
| [google_service_account_iam_binding.service_account_iam_binding](https://registry.terraform.io/providers/hashicorp/google/6.27.0/docs/resources/service_account_iam_binding) | resource |
| [google_service_account_iam_member.service_account_iam_member](https://registry.terraform.io/providers/hashicorp/google/6.27.0/docs/resources/service_account_iam_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_google_project_iam_binding"></a> [google\_project\_iam\_binding](#input\_google\_project\_iam\_binding) | Google project iam binding | <pre>list(object({<br>      role = string<br>      members = optional(list(string), [])<br>    }))</pre> | `[]` | no |
| <a name="input_google_project_iam_member"></a> [google\_project\_iam\_member](#input\_google\_project\_iam\_member) | Google project iam member | <pre>list(object({<br>      role = string<br>      member = optional(string, "")<br>    }))</pre> | `[]` | no |
| <a name="input_google_service_account_account_id"></a> [google\_service\_account\_account\_id](#input\_google\_service\_account\_account\_id) | Google service account ID | `string` | n/a | yes |
| <a name="input_google_service_account_display_name"></a> [google\_service\_account\_display\_name](#input\_google\_service\_account\_display\_name) | Google service account display name | `string` | n/a | yes |
| <a name="input_google_service_account_iam_binding"></a> [google\_service\_account\_iam\_binding](#input\_google\_service\_account\_iam\_binding) | Google service account iam binding | <pre>list(object({<br>      role = string<br>      members = list(string)<br>    }))</pre> | `[]` | no |
| <a name="input_google_service_account_iam_member"></a> [google\_service\_account\_iam\_member](#input\_google\_service\_account\_iam\_member) | Google service account iam member | <pre>list(object({<br>      role = string<br>      member = string<br>    }))</pre> | `[]` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | GCP Project ID | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | GCP region | `string` | n/a | yes |

## Outputs

No outputs.

## Planned Enhancements
- Add **condition blocks** in google_project_iam and google_service_account_iam resources
