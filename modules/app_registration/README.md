<!-- BEGIN_TF_DOCS -->
# terraform-aviatrix-azure-controlplane - app-registration

### Description
This submodule creates an app registration in Azure.

### Usage Example
```hcl
module "app_registration" {
  source   = "./modules/app_registration"
  app_name = "my_controller"
}
```
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | Azure AD App Name for Aviatrix Controller Build Up | `string` | `"aviatrix_controller_app"` | no |
| <a name="input_create_custom_role"></a> [create\_custom\_role](#input\_create\_custom\_role) | Enable creation of custom role in stead of using contributor permissions | `bool` | `false` | no |
| <a name="input_use_existing_mp_agreement"></a> [use\_existing\_mp\_agreement](#input\_use\_existing\_mp\_agreement) | Flag to indicate whether to use an existing marketplace agreement | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_application_key"></a> [application\_key](#output\_application\_key) | n/a |
| <a name="output_client_id"></a> [client\_id](#output\_client\_id) | n/a |
| <a name="output_directory_id"></a> [directory\_id](#output\_directory\_id) | n/a |
| <a name="output_subscription_id"></a> [subscription\_id](#output\_subscription\_id) | n/a |
<!-- END_TF_DOCS -->