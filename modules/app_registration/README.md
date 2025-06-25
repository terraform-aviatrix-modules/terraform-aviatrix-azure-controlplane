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
| <a name="input_app_password_validity_length"></a> [app\_password\_validity\_length](#input\_app\_password\_validity\_length) | Number of hours from the apply time. Will be converted to the ISO 8601 extended date and time format automatically | `string` | `"730h"` | no |
| <a name="input_aviatrix_rgs"></a> [aviatrix\_rgs](#input\_aviatrix\_rgs) | Resorce groups with the Aviatrix managed entities. Controller permissions to modify resources in these RGs | `map(list(string))` | `{}` | no |
| <a name="input_aviatrix_role_names"></a> [aviatrix\_role\_names](#input\_aviatrix\_role\_names) | Aviatrix role names for use by the controller | `map(string)` | <pre>{<br/>  "backup_name": "aviatrix-backup",<br/>  "read_only_name": "aviatrix-read-only",<br/>  "service_name": "aviatrix-service",<br/>  "transit_gw_name": "aviatrix-transit-gateways"<br/>}</pre> | no |
| <a name="input_controller_rg"></a> [controller\_rg](#input\_controller\_rg) | Controller RG used for roles if resource group level scope enabled | `string` | `""` | no |
| <a name="input_create_custom_role"></a> [create\_custom\_role](#input\_create\_custom\_role) | Enable creation of custom role in stead of using contributor permissions | `bool` | `false` | no |
| <a name="input_subscription_ids"></a> [subscription\_ids](#input\_subscription\_ids) | Subscriptions with the Aviatrix gateways. Aviatrix role will be created in the first one. Controller will have read-only access to this list | `list(string)` | `[]` | no |
| <a name="input_use_existing_mp_agreement"></a> [use\_existing\_mp\_agreement](#input\_use\_existing\_mp\_agreement) | Flag to indicate whether to use an existing marketplace agreement | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_application_key"></a> [application\_key](#output\_application\_key) | n/a |
| <a name="output_client_id"></a> [client\_id](#output\_client\_id) | n/a |
| <a name="output_directory_id"></a> [directory\_id](#output\_directory\_id) | n/a |
| <a name="output_subscription_id"></a> [subscription\_id](#output\_subscription\_id) | n/a |
<!-- END_TF_DOCS -->