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
| <a name="input_controller_name"></a> [controller\_name](#input\_controller\_name) | Customized Name for Aviatrix Controller | `string` | n/a | yes |
| <a name="input_controller_subnet_cidr"></a> [controller\_subnet\_cidr](#input\_controller\_subnet\_cidr) | CIDR for controller subnet. | `string` | `"10.0.0.0/24"` | no |
| <a name="input_controller_virtual_machine_admin_password"></a> [controller\_virtual\_machine\_admin\_password](#input\_controller\_virtual\_machine\_admin\_password) | Admin Password for the controller virtual machine. | `string` | `"aviatrix1234!"` | no |
| <a name="input_controller_virtual_machine_admin_username"></a> [controller\_virtual\_machine\_admin\_username](#input\_controller\_virtual\_machine\_admin\_username) | Admin Username for the controller virtual machine. | `string` | `"aviatrix"` | no |
| <a name="input_controller_virtual_machine_size"></a> [controller\_virtual\_machine\_size](#input\_controller\_virtual\_machine\_size) | Virtual Machine size for the controller. | `string` | `"Standard_A4_v2"` | no |
| <a name="input_controller_vnet_cidr"></a> [controller\_vnet\_cidr](#input\_controller\_vnet\_cidr) | CIDR for controller VNET. | `string` | `"10.0.0.0/24"` | no |
| <a name="input_incoming_ssl_cidrs"></a> [incoming\_ssl\_cidrs](#input\_incoming\_ssl\_cidrs) | Incoming cidrs for security group used by controller | `list(string)` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Resource Group Location for Aviatrix Controller | `string` | `"West US"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group name, only required when use\_existing\_vnet is true | `string` | `""` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | Subnet ID, only required when use\_existing\_vnet is true | `string` | `""` | no |
| <a name="input_subnet_name"></a> [subnet\_name](#input\_subnet\_name) | subnet name, only required when use\_existing\_vnet is true | `string` | `""` | no |
| <a name="input_use_existing_vnet"></a> [use\_existing\_vnet](#input\_use\_existing\_vnet) | Flag to indicate whether to use an existing VNET | `bool` | `false` | no |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | VNET name, only required when use\_existing\_vnet is true | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_controller_name"></a> [controller\_name](#output\_controller\_name) | n/a |
| <a name="output_controller_nsg"></a> [controller\_nsg](#output\_controller\_nsg) | n/a |
| <a name="output_controller_private_ip_address"></a> [controller\_private\_ip\_address](#output\_controller\_private\_ip\_address) | n/a |
| <a name="output_controller_public_ip_address"></a> [controller\_public\_ip\_address](#output\_controller\_public\_ip\_address) | n/a |
| <a name="output_controller_rg_name"></a> [controller\_rg\_name](#output\_controller\_rg\_name) | n/a |
| <a name="output_controller_subnet_id"></a> [controller\_subnet\_id](#output\_controller\_subnet\_id) | n/a |
| <a name="output_controller_subnet_name"></a> [controller\_subnet\_name](#output\_controller\_subnet\_name) | n/a |
| <a name="output_controller_vnet_name"></a> [controller\_vnet\_name](#output\_controller\_vnet\_name) | n/a |
| <a name="output_location"></a> [location](#output\_location) | n/a |
<!-- END_TF_DOCS -->