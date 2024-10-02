# Aviatrix Controller Build

This module builds and launches the Aviatrix Controller VM instance.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 2.8.0 |
| <a name="provider_http"></a> [http](#provider\_http) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_linux_virtual_machine.controller_vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_network_interface.controller_nic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_network_interface_security_group_association.controller_nic_sg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_security_group_association) | resource |
| [azurerm_network_security_group.controller_nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_rule.controller_nsg_rule_https](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_public_ip.controller_public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_resource_group.controller_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_subnet.controller_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_virtual_network.controller_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [azurerm_public_ip.controller_public_ip_address](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/public_ip) | data source |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |
| [http_http.image_info](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_controller_name"></a> [controller\_name](#input\_controller\_name) | Customized Name for Aviatrix Controller | `string` | n/a | yes |
| <a name="input_controller_subnet_cidr"></a> [controller\_subnet\_cidr](#input\_controller\_subnet\_cidr) | CIDR for controller subnet. | `string` | `"10.0.0.0/24"` | no |
| <a name="input_controller_virtual_machine_admin_password"></a> [controller\_virtual\_machine\_admin\_password](#input\_controller\_virtual\_machine\_admin\_password) | Admin Password for the controller virtual machine. | `string` | `"aviatrix1234!"` | no |
| <a name="input_controller_virtual_machine_admin_username"></a> [controller\_virtual\_machine\_admin\_username](#input\_controller\_virtual\_machine\_admin\_username) | Admin Username for the controller virtual machine. | `string` | `"aviatrix"` | no |
| <a name="input_controller_virtual_machine_size"></a> [controller\_virtual\_machine\_size](#input\_controller\_virtual\_machine\_size) | Virtual Machine size for the controller. | `string` | `"Standard_A4_v2"` | no |
| <a name="input_controller_vnet_cidr"></a> [controller\_vnet\_cidr](#input\_controller\_vnet\_cidr) | CIDR for controller VNET. | `string` | `"10.0.0.0/24"` | no |
| <a name="input_incoming_ssl_cidr"></a> [incoming\_ssl\_cidr](#input\_incoming\_ssl\_cidr) | Incoming cidr for security group used by controller | `list(string)` | n/a | yes |
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
| <a name="output_controller_rg"></a> [controller\_rg](#output\_controller\_rg) | n/a |
| <a name="output_controller_subnet"></a> [controller\_subnet](#output\_controller\_subnet) | n/a |
| <a name="output_controller_vnet"></a> [controller\_vnet](#output\_controller\_vnet) | n/a |
