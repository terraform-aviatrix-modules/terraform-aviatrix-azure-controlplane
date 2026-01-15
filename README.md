<!-- BEGIN_TF_DOCS -->
# terraform-aviatrix-azure-controlplane

### Description
This module deploys the Aviatrix control plane, or individual parts thereof.

### Quick Start with CloudShell
For users who want to deploy quickly without managing Terraform state or complex configurations, we provide a simplified CloudShell deployment script that wraps this module. This option is perfect for getting started quickly or for one-time deployments.

👉 **[CloudShell Deployment Guide](./cloudshell/README.md)**

### Requirements
This module assumes you have Azure CLI installed and are authenticated with sufficient privileges.

### Compatibility
Module version | Terraform version
:--- | :---
v1.1.6 | >= 1.3.0

### Usage Example
```hcl
provider "azurerm" {
  features {}
  skip_provider_registration = true
}

module "control_plane" {
  source  = "terraform-aviatrix-modules/azure-controlplane/aviatrix"
  version = "1.1.6"

  controller_name           = "my_controller"
  incoming_ssl_cidrs        = ["1.2.3.4"]
  controller_admin_email    = "admin@domain.com"
  controller_admin_password = "mysecretpassword"
  account_email             = "admin@domain.com"
  access_account_name       = "Azure"
  customer_id               = "xxxxxxx-abu-xxxxxxxxx"
  location                  = "East US"
}

output "controlplane_data" {
  value = module.control_plane
}
```
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_account_name"></a> [access\_account\_name](#input\_access\_account\_name) | aviatrix controller access account name | `string` | `""` | no |
| <a name="input_account_email"></a> [account\_email](#input\_account\_email) | aviatrix controller access account email | `string` | `""` | no |
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | Azure AD App Name for Aviatrix Controller Build Up | `string` | `"aviatrix_controller_app"` | no |
| <a name="input_app_password_validity_length"></a> [app\_password\_validity\_length](#input\_app\_password\_validity\_length) | Number of hours the app secret will be valid from the apply time. Default is a month | `string` | `"730h"` | no |
| <a name="input_aviatrix_rgs"></a> [aviatrix\_rgs](#input\_aviatrix\_rgs) | Only used when create\_custom\_role = true. Defines resorce groups with the Aviatrix managed entities. Controller will have permissions to modify resources in these RGs | `map(list(string))` | `{}` | no |
| <a name="input_aviatrix_role_names"></a> [aviatrix\_role\_names](#input\_aviatrix\_role\_names) | Aviatrix role names for use by the controller | `map(string)` | <pre>{<br/>  "backup_name": "aviatrix-backup",<br/>  "read_only_name": "aviatrix-read-only",<br/>  "service_name": "aviatrix-service",<br/>  "transit_gw_name": "aviatrix-transit-gateways"<br/>}</pre> | no |
| <a name="input_cloud_type"></a> [cloud\_type](#input\_cloud\_type) | Select a cloud type. Valid options are "commercial", "china". | `string` | `"commercial"` | no |
| <a name="input_controller_admin_email"></a> [controller\_admin\_email](#input\_controller\_admin\_email) | aviatrix controller admin email address | `string` | n/a | yes |
| <a name="input_controller_admin_password"></a> [controller\_admin\_password](#input\_controller\_admin\_password) | aviatrix controller admin password | `string` | n/a | yes |
| <a name="input_controller_name"></a> [controller\_name](#input\_controller\_name) | Customized Name for Aviatrix Controller | `string` | `"Aviatrix-Controller"` | no |
| <a name="input_controller_public_ip_name"></a> [controller\_public\_ip\_name](#input\_controller\_public\_ip\_name) | Public IP name, only required when use\_existing\_controller\_public\_ip is true | `string` | `""` | no |
| <a name="input_controller_version"></a> [controller\_version](#input\_controller\_version) | Aviatrix Controller version | `string` | `"latest"` | no |
| <a name="input_controller_virtual_machine_admin_password"></a> [controller\_virtual\_machine\_admin\_password](#input\_controller\_virtual\_machine\_admin\_password) | Admin Password for the controller virtual machine. | `string` | `"aviatrix1234!"` | no |
| <a name="input_controller_virtual_machine_admin_username"></a> [controller\_virtual\_machine\_admin\_username](#input\_controller\_virtual\_machine\_admin\_username) | Admin Username for the controller virtual machine. | `string` | `"aviatrix"` | no |
| <a name="input_controller_virtual_machine_size"></a> [controller\_virtual\_machine\_size](#input\_controller\_virtual\_machine\_size) | Virtual Machine size for the controller. | `string` | `"Standard_A4_v2"` | no |
| <a name="input_controlplane_subnet_cidr"></a> [controlplane\_subnet\_cidr](#input\_controlplane\_subnet\_cidr) | CIDR for controlplane subnet. | `string` | `"10.0.0.0/24"` | no |
| <a name="input_controlplane_vnet_cidr"></a> [controlplane\_vnet\_cidr](#input\_controlplane\_vnet\_cidr) | CIDR for controller VNET. | `string` | `"10.0.0.0/24"` | no |
| <a name="input_copilot_data_disk_size"></a> [copilot\_data\_disk\_size](#input\_copilot\_data\_disk\_size) | Aviatrix-Copilot data disk size - use 1TB for production | `string` | `"100"` | no |
| <a name="input_copilot_image_version"></a> [copilot\_image\_version](#input\_copilot\_image\_version) | Version of the Aviatrix Copilot image to use. Set to 'latest' to use the most recent version. | `string` | `"latest"` | no |
| <a name="input_copilot_name"></a> [copilot\_name](#input\_copilot\_name) | Customized Name for Aviatrix Copilot | `string` | `"Aviatrix-Copilot"` | no |
| <a name="input_copilot_public_ip_name"></a> [copilot\_public\_ip\_name](#input\_copilot\_public\_ip\_name) | Public IP name, only required when use\_existing\_copilot\_public\_ip is true | `string` | `""` | no |
| <a name="input_copilot_virtual_machine_size"></a> [copilot\_virtual\_machine\_size](#input\_copilot\_virtual\_machine\_size) | Virtual Machine size for the copilot | `string` | `"Standard_B4ms"` | no |
| <a name="input_create_custom_role"></a> [create\_custom\_role](#input\_create\_custom\_role) | Enable creation of custom role in stead of using contributor permissions | `bool` | `false` | no |
| <a name="input_create_storage_account"></a> [create\_storage\_account](#input\_create\_storage\_account) | Storage account used for the controller backup and terraform state | `bool` | `true` | no |
| <a name="input_customer_id"></a> [customer\_id](#input\_customer\_id) | aviatrix customer license id | `string` | n/a | yes |
| <a name="input_incoming_ssl_cidrs"></a> [incoming\_ssl\_cidrs](#input\_incoming\_ssl\_cidrs) | Incoming cidrs for security group used by controller | `list(string)` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Resource Group Location for Aviatrix Controller | `string` | `"West US"` | no |
| <a name="input_module_config"></a> [module\_config](#input\_module\_config) | n/a | `map` | <pre>{<br/>  "accept_controller_subscription": true,<br/>  "accept_copilot_subscription": true,<br/>  "account_onboarding": true,<br/>  "app_registration": true,<br/>  "controller_deployment": true,<br/>  "controller_initialization": true,<br/>  "copilot_deployment": true,<br/>  "copilot_initialization": true<br/>}</pre> | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group name, only required when use\_existing\_recource\_group is true | `string` | `""` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | Subnet ID, only required when use\_existing\_vnet is true | `string` | `""` | no |
| <a name="input_subnet_name"></a> [subnet\_name](#input\_subnet\_name) | subnet name, only required when use\_existing\_vnet is true | `string` | `""` | no |
| <a name="input_subscription_ids"></a> [subscription\_ids](#input\_subscription\_ids) | Subscriptions with the Aviatrix gateways. Aviatrix role will be created in the first one. Controller will have read-only access if aviatrix\_rgs is not empty. | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Provide tags for resources created by the module | `map(string)` | `{}` | no |
| <a name="input_use_existing_controller_public_ip"></a> [use\_existing\_controller\_public\_ip](#input\_use\_existing\_controller\_public\_ip) | Flag to indicate whether to use an existing public ip | `bool` | `false` | no |
| <a name="input_use_existing_copilot_public_ip"></a> [use\_existing\_copilot\_public\_ip](#input\_use\_existing\_copilot\_public\_ip) | Flag to indicate whether to use an existing public ip | `bool` | `false` | no |
| <a name="input_use_existing_resource_group"></a> [use\_existing\_resource\_group](#input\_use\_existing\_resource\_group) | Flag to indicate whether to use an existing resource group | `bool` | `false` | no |
| <a name="input_use_existing_vnet"></a> [use\_existing\_vnet](#input\_use\_existing\_vnet) | Flag to indicate whether to use an existing VNET | `bool` | `false` | no |
| <a name="input_virtual_machine_admin_password"></a> [virtual\_machine\_admin\_password](#input\_virtual\_machine\_admin\_password) | n/a | `string` | `""` | no |
| <a name="input_virtual_machine_admin_username"></a> [virtual\_machine\_admin\_username](#input\_virtual\_machine\_admin\_username) | n/a | `string` | `"avx_admin"` | no |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | VNET name, only required when use\_existing\_vnet is true | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_application_key"></a> [application\_key](#output\_application\_key) | n/a |
| <a name="output_backup_container_name"></a> [backup\_container\_name](#output\_backup\_container\_name) | n/a |
| <a name="output_client_id"></a> [client\_id](#output\_client\_id) | n/a |
| <a name="output_controller_name"></a> [controller\_name](#output\_controller\_name) | n/a |
| <a name="output_controller_private_ip"></a> [controller\_private\_ip](#output\_controller\_private\_ip) | n/a |
| <a name="output_controller_public_ip"></a> [controller\_public\_ip](#output\_controller\_public\_ip) | n/a |
| <a name="output_controller_rg_name"></a> [controller\_rg\_name](#output\_controller\_rg\_name) | n/a |
| <a name="output_controller_vm_id"></a> [controller\_vm\_id](#output\_controller\_vm\_id) | n/a |
| <a name="output_controller_vnet_id"></a> [controller\_vnet\_id](#output\_controller\_vnet\_id) | n/a |
| <a name="output_controller_vnet_name"></a> [controller\_vnet\_name](#output\_controller\_vnet\_name) | n/a |
| <a name="output_copilot_private_ip"></a> [copilot\_private\_ip](#output\_copilot\_private\_ip) | n/a |
| <a name="output_copilot_public_ip"></a> [copilot\_public\_ip](#output\_copilot\_public\_ip) | n/a |
| <a name="output_directory_id"></a> [directory\_id](#output\_directory\_id) | n/a |
| <a name="output_storage_account_name"></a> [storage\_account\_name](#output\_storage\_account\_name) | n/a |
| <a name="output_summary"></a> [summary](#output\_summary) | n/a |
| <a name="output_terraform_container_name"></a> [terraform\_container\_name](#output\_terraform\_container\_name) | n/a |
<!-- END_TF_DOCS -->
