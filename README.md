<!-- BEGIN_TF_DOCS -->
# terraform-aviatrix-azure-controlplane

### Description
This module deploys the Aviatrix control plane, or individual parts thereof.

### Requirements
This module assumes you have Azure CLI installed and are authenticated with sufficient privileges.

### Compatibility
Module version | Terraform version
:--- | :---
v1.0.0 | >= 1.3.0

### Usage Example
```hcl
provider "azurerm" {
  features {}
}

module "control_plane" {
  source  = "terraform-aviatrix-modules/azure-controlplane/aviatrix"
  version = "1.0.0"

  controller_name               = "my_controller"
  incoming_ssl_cidr             = ["1.2.3.4"]
  avx_controller_admin_email    = "admin@domain.com"
  avx_controller_admin_password = "mysecretpassword"
  account_email                 = "admin@domain.com"
  access_account_name           = "Azure"
  customer_id                   = "xxxxxxx-abu-xxxxxxxxx"
}

output "controlplane_data" {
  value = module.control_plane
}
```
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_account_name"></a> [access\_account\_name](#input\_access\_account\_name) | aviatrix controller access account name | `string` | n/a | yes |
| <a name="input_account_email"></a> [account\_email](#input\_account\_email) | aviatrix controller access account email | `string` | n/a | yes |
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | Azure AD App Name for Aviatrix Controller Build Up | `string` | `"aviatrix_controller_app"` | no |
| <a name="input_controller_admin_email"></a> [controller\_admin\_email](#input\_controller\_admin\_email) | aviatrix controller admin email address | `string` | n/a | yes |
| <a name="input_controller_admin_password"></a> [controller\_admin\_password](#input\_controller\_admin\_password) | aviatrix controller admin password | `string` | n/a | yes |
| <a name="input_controller_name"></a> [controller\_name](#input\_controller\_name) | Customized Name for Aviatrix Controller | `string` | `"Aviatrix-Controller"` | no |
| <a name="input_controller_version"></a> [controller\_version](#input\_controller\_version) | Aviatrix Controller version | `string` | `"latest"` | no |
| <a name="input_controller_virtual_machine_admin_password"></a> [controller\_virtual\_machine\_admin\_password](#input\_controller\_virtual\_machine\_admin\_password) | Admin Password for the controller virtual machine. | `string` | `"aviatrix1234!"` | no |
| <a name="input_controller_virtual_machine_admin_username"></a> [controller\_virtual\_machine\_admin\_username](#input\_controller\_virtual\_machine\_admin\_username) | Admin Username for the controller virtual machine. | `string` | `"aviatrix"` | no |
| <a name="input_controller_virtual_machine_size"></a> [controller\_virtual\_machine\_size](#input\_controller\_virtual\_machine\_size) | Virtual Machine size for the controller. | `string` | `"Standard_A4_v2"` | no |
| <a name="input_controlplane_subnet_cidr"></a> [controlplane\_subnet\_cidr](#input\_controlplane\_subnet\_cidr) | CIDR for controlplane subnet. | `string` | `"10.0.0.0/24"` | no |
| <a name="input_controlplane_vnet_cidr"></a> [controlplane\_vnet\_cidr](#input\_controlplane\_vnet\_cidr) | CIDR for controller VNET. | `string` | `"10.0.0.0/24"` | no |
| <a name="input_copilot_name"></a> [copilot\_name](#input\_copilot\_name) | Customized Name for Aviatrix Copilot | `string` | `"Aviatrix-Copilot"` | no |
| <a name="input_create_custom_role"></a> [create\_custom\_role](#input\_create\_custom\_role) | Enable creation of custom role in stead of using contributor permissions | `bool` | `false` | no |
| <a name="input_customer_id"></a> [customer\_id](#input\_customer\_id) | aviatrix customer license id | `string` | n/a | yes |
| <a name="input_incoming_ssl_cidr"></a> [incoming\_ssl\_cidr](#input\_incoming\_ssl\_cidr) | Incoming cidr for security group used by controller | `list(string)` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Resource Group Location for Aviatrix Controller | `string` | `"West US"` | no |
| <a name="input_module_config"></a> [module\_config](#input\_module\_config) | n/a | `map` | <pre>{<br/>  "accept_controller_subscription": true,<br/>  "accept_copilot_subscription": true,<br/>  "account_onboarding": true,<br/>  "app_registration": true,<br/>  "controller_deployment": true,<br/>  "controller_initialization": true,<br/>  "copilot_deployment": true,<br/>  "copilot_initialization": true<br/>}</pre> | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group name, only required when use\_existing\_vnet is true | `string` | `""` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | Subnet ID, only required when use\_existing\_vnet is true | `string` | `""` | no |
| <a name="input_subnet_name"></a> [subnet\_name](#input\_subnet\_name) | subnet name, only required when use\_existing\_vnet is true | `string` | `""` | no |
| <a name="input_use_existing_vnet"></a> [use\_existing\_vnet](#input\_use\_existing\_vnet) | Flag to indicate whether to use an existing VNET | `bool` | `false` | no |
| <a name="input_virtual_machine_admin_password"></a> [virtual\_machine\_admin\_password](#input\_virtual\_machine\_admin\_password) | n/a | `string` | `""` | no |
| <a name="input_virtual_machine_admin_username"></a> [virtual\_machine\_admin\_username](#input\_virtual\_machine\_admin\_username) | n/a | `string` | `"avx_admin"` | no |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | VNET name, only required when use\_existing\_vnet is true | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_controller_private_ip"></a> [controller\_private\_ip](#output\_controller\_private\_ip) | n/a |
| <a name="output_controller_public_ip"></a> [controller\_public\_ip](#output\_controller\_public\_ip) | n/a |
| <a name="output_copilot_private_ip"></a> [copilot\_private\_ip](#output\_copilot\_private\_ip) | n/a |
| <a name="output_copilot_public_ip"></a> [copilot\_public\_ip](#output\_copilot\_public\_ip) | n/a |
<!-- END_TF_DOCS -->