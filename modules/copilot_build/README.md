## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |
| <a name="provider_http"></a> [http](#provider\_http) | n/a |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |
| <a name="provider_tls"></a> [tls](#provider\_tls) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_linux_virtual_machine.copilot_vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_linux_virtual_machine.copilot_vm_ssh](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_managed_disk.default](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/managed_disk) | resource |
| [azurerm_network_interface.copilot_nic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_network_interface_security_group_association.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_security_group_association) | resource |
| [azurerm_network_security_group.copilot_nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_public_ip.copilot_public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_resource_group.copilot_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_subnet.copilot_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_virtual_machine_data_disk_attachment.default](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_data_disk_attachment) | resource |
| [azurerm_virtual_machine_data_disk_attachment.disk_att](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_data_disk_attachment) | resource |
| [azurerm_virtual_network.copilot_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [time_sleep.sleep_10min](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [time_sleep.sleep_10min_ssh](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [tls_private_key.key_pair_material](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [http_http.image_info](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_add_ssh_key"></a> [add\_ssh\_key](#input\_add\_ssh\_key) | Flag to indicate whether to add an SSH key | `bool` | `false` | no |
| <a name="input_additional_disks"></a> [additional\_disks](#input\_additional\_disks) | n/a | <pre>map(object({<br/>    managed_disk_id = string,<br/>    lun             = string,<br/>  }))</pre> | `{}` | no |
| <a name="input_allowed_cidrs"></a> [allowed\_cidrs](#input\_allowed\_cidrs) | n/a | <pre>map(object({<br/>    priority = string,<br/>    protocol = string,<br/>    ports    = set(string),<br/>    cidrs    = set(string),<br/>  }))</pre> | n/a | yes |
| <a name="input_controller_private_ip"></a> [controller\_private\_ip](#input\_controller\_private\_ip) | Controller private IP | `string` | n/a | yes |
| <a name="input_controller_public_ip"></a> [controller\_public\_ip](#input\_controller\_public\_ip) | Controller public IP | `string` | `"0.0.0.0"` | no |
| <a name="input_copilot_name"></a> [copilot\_name](#input\_copilot\_name) | Customized Name for Aviatrix Copilot | `string` | n/a | yes |
| <a name="input_default_data_disk_name"></a> [default\_data\_disk\_name](#input\_default\_data\_disk\_name) | Name of default data disk. | `string` | `"default-data-disk"` | no |
| <a name="input_default_data_disk_size"></a> [default\_data\_disk\_size](#input\_default\_data\_disk\_size) | Size of default data disk. If not set, no default data disk will be created. | `number` | `0` | no |
| <a name="input_is_cluster"></a> [is\_cluster](#input\_is\_cluster) | Flag to indicate whether the copilot is for a cluster | `bool` | `false` | no |
| <a name="input_location"></a> [location](#input\_location) | Resource Group Location for Aviatrix Copilot | `string` | `"West US"` | no |
| <a name="input_os_disk_name"></a> [os\_disk\_name](#input\_os\_disk\_name) | OS disk name of the copilot virtual machine | `string` | `""` | no |
| <a name="input_os_disk_size"></a> [os\_disk\_size](#input\_os\_disk\_size) | OS disk size for copilot | `number` | `30` | no |
| <a name="input_private_mode"></a> [private\_mode](#input\_private\_mode) | Flag to indicate whether the copilot is for private mode | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group name, only required when use\_existing\_vnet is true | `string` | `""` | no |
| <a name="input_ssh_public_key_file_content"></a> [ssh\_public\_key\_file\_content](#input\_ssh\_public\_key\_file\_content) | File content of the SSH public key | `string` | `""` | no |
| <a name="input_ssh_public_key_file_path"></a> [ssh\_public\_key\_file\_path](#input\_ssh\_public\_key\_file\_path) | File path to the SSH public key | `string` | `""` | no |
| <a name="input_subnet_cidr"></a> [subnet\_cidr](#input\_subnet\_cidr) | CIDR for copilot subnet | `string` | `"10.0.1.0/24"` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | Subnet ID, only required when use\_existing\_vnet is true | `string` | `""` | no |
| <a name="input_use_existing_ssh_key"></a> [use\_existing\_ssh\_key](#input\_use\_existing\_ssh\_key) | Flag to indicate whether to use an existing SSH key | `bool` | `false` | no |
| <a name="input_use_existing_vnet"></a> [use\_existing\_vnet](#input\_use\_existing\_vnet) | Flag to indicate whether to use an existing VNET | `bool` | `false` | no |
| <a name="input_virtual_machine_admin_password"></a> [virtual\_machine\_admin\_password](#input\_virtual\_machine\_admin\_password) | Admin Password for the copilot virtual machine | `string` | `""` | no |
| <a name="input_virtual_machine_admin_username"></a> [virtual\_machine\_admin\_username](#input\_virtual\_machine\_admin\_username) | Admin Username for the copilot virtual machine | `string` | n/a | yes |
| <a name="input_virtual_machine_size"></a> [virtual\_machine\_size](#input\_virtual\_machine\_size) | Virtual Machine size for the copilot | `string` | `"Standard_B4ms"` | no |
| <a name="input_vnet_cidr"></a> [vnet\_cidr](#input\_vnet\_cidr) | CIDR for copilot VNET | `string` | `"10.0.0.0/16"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_network_security_group_name"></a> [network\_security\_group\_name](#output\_network\_security\_group\_name) | n/a |
| <a name="output_private_ip"></a> [private\_ip](#output\_private\_ip) | n/a |
| <a name="output_public_ip"></a> [public\_ip](#output\_public\_ip) | n/a |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | n/a |
| <a name="output_ssh_public_key"></a> [ssh\_public\_key](#output\_ssh\_public\_key) | n/a |
