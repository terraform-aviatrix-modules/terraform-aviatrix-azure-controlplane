<!-- BEGIN_TF_DOCS -->
# terraform-aviatrix-azure-controlplane - controller-build

### Description
This submodule creates the controller virtual machine and related components.

### Usage Example
```hcl
module "controller_build" {
  source = "./modules/controller_build"
  // please do not use special characters such as `\/"[]:|<>+=;,?*@&~!#$%^()_{}'` in the controller_name
  controller_name                           = "my_controller"
  location                                  = "East US"
  controller_vnet_cidr                      = "10.0.0.0/24"
  controller_subnet_cidr                    = "10.0.0.0/24"
  controller_virtual_machine_admin_username = "avxadmin"
  controller_virtual_machine_admin_password = "my_password"
  incoming_ssl_cidrs                        = ["1.2.3.4/32"]
}
```
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloud_type"></a> [cloud\_type](#input\_cloud\_type) | Determines which cloud should we subscribe offer | `string` | `"commercial"` | no |
| <a name="input_controller_name"></a> [controller\_name](#input\_controller\_name) | Customized Name for Aviatrix Controller | `string` | n/a | yes |
| <a name="input_controller_subnet_cidr"></a> [controller\_subnet\_cidr](#input\_controller\_subnet\_cidr) | CIDR for controller subnet. | `string` | `"10.0.0.0/24"` | no |
| <a name="input_controller_version"></a> [controller\_version](#input\_controller\_version) | Aviatrix Controller version | `string` | `"latest"` | no |
| <a name="input_controller_virtual_machine_admin_password"></a> [controller\_virtual\_machine\_admin\_password](#input\_controller\_virtual\_machine\_admin\_password) | Admin Password for the controller virtual machine. | `string` | `"aviatrix1234!"` | no |
| <a name="input_controller_virtual_machine_admin_username"></a> [controller\_virtual\_machine\_admin\_username](#input\_controller\_virtual\_machine\_admin\_username) | Admin Username for the controller virtual machine. | `string` | `"aviatrix"` | no |
| <a name="input_controller_virtual_machine_size"></a> [controller\_virtual\_machine\_size](#input\_controller\_virtual\_machine\_size) | Virtual Machine size for the controller. | `string` | `"Standard_A4_v2"` | no |
| <a name="input_controller_vnet_cidr"></a> [controller\_vnet\_cidr](#input\_controller\_vnet\_cidr) | CIDR for controller VNET. | `string` | `"10.0.0.0/24"` | no |
| <a name="input_create_storage_account"></a> [create\_storage\_account](#input\_create\_storage\_account) | Storage account used for the controller backup and terraform state | `bool` | `true` | no |
| <a name="input_incoming_service_tags"></a> [incoming\_service\_tags](#input\_incoming\_service\_tags) | Incoming service tags for security group used by controller | `list(string)` | `[]` | no |
| <a name="input_incoming_ssl_cidrs"></a> [incoming\_ssl\_cidrs](#input\_incoming\_ssl\_cidrs) | Incoming cidrs for security group used by controller | `list(string)` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Resource Group Location for Aviatrix Controller | `string` | `"West US"` | no |
| <a name="input_public_ip_name"></a> [public\_ip\_name](#input\_public\_ip\_name) | Public IP name, only required when use\_existing\_public\_ip is true | `string` | `""` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group name. Required when use\_existing\_resource\_group is true or when using existing public IP or vnet. | `string` | `""` | no |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | Azure storage account name. | `string` | `""` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | Subnet ID, only required when use\_existing\_vnet is true | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Provide tags for resources created by the module | `map(string)` | `{}` | no |
| <a name="input_use_existing_public_ip"></a> [use\_existing\_public\_ip](#input\_use\_existing\_public\_ip) | Flag to indicate whether to use an existing public ip | `bool` | `false` | no |
| <a name="input_use_existing_resource_group"></a> [use\_existing\_resource\_group](#input\_use\_existing\_resource\_group) | Flag to indicate whether to use an existing resource group | `bool` | `false` | no |
| <a name="input_use_existing_vnet"></a> [use\_existing\_vnet](#input\_use\_existing\_vnet) | Flag to indicate whether to use an existing VNET | `bool` | `false` | no |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | VNET name, only required when use\_existing\_vnet is true | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_backup_container_name"></a> [backup\_container\_name](#output\_backup\_container\_name) | n/a |
| <a name="output_controller_name"></a> [controller\_name](#output\_controller\_name) | n/a |
| <a name="output_controller_nsg"></a> [controller\_nsg](#output\_controller\_nsg) | n/a |
| <a name="output_controller_private_ip_address"></a> [controller\_private\_ip\_address](#output\_controller\_private\_ip\_address) | n/a |
| <a name="output_controller_public_ip_address"></a> [controller\_public\_ip\_address](#output\_controller\_public\_ip\_address) | n/a |
| <a name="output_controller_rg_name"></a> [controller\_rg\_name](#output\_controller\_rg\_name) | n/a |
| <a name="output_controller_subnet_id"></a> [controller\_subnet\_id](#output\_controller\_subnet\_id) | n/a |
| <a name="output_controller_subnet_name"></a> [controller\_subnet\_name](#output\_controller\_subnet\_name) | n/a |
| <a name="output_controller_vm_id"></a> [controller\_vm\_id](#output\_controller\_vm\_id) | n/a |
| <a name="output_controller_vnet_id"></a> [controller\_vnet\_id](#output\_controller\_vnet\_id) | n/a |
| <a name="output_controller_vnet_name"></a> [controller\_vnet\_name](#output\_controller\_vnet\_name) | n/a |
| <a name="output_location"></a> [location](#output\_location) | n/a |
| <a name="output_storage_account_name"></a> [storage\_account\_name](#output\_storage\_account\_name) | n/a |
| <a name="output_terraform_container_name"></a> [terraform\_container\_name](#output\_terraform\_container\_name) | n/a |
<!-- END_TF_DOCS -->