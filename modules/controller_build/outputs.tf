output "controller_public_ip_address" {
  value = azurerm_public_ip.controller_public_ip.ip_address
}

output "controller_private_ip_address" {
  value = azurerm_network_interface.controller_nic.private_ip_address
}

output "controller_rg_name" {
  value = var.use_existing_vnet ? var.resource_group_name : azurerm_resource_group.controller_rg[0].name
}

output "controller_nsg" {
  value = azurerm_network_security_group.controller_nsg
}

output "controller_vnet_name" {
  value = var.use_existing_vnet ? var.vnet_name : azurerm_virtual_network.controller_vnet[0].name
}

output "controller_subnet_name" {
  value = var.use_existing_vnet ? var.subnet_name : azurerm_subnet.controller_subnet[0].name
}

output "controller_subnet_id" {
  value = var.use_existing_vnet ? var.subnet_id : azurerm_subnet.controller_subnet[0].id
}

output "controller_name" {
  value = azurerm_linux_virtual_machine.controller_vm.name
}

output "location" {
  value = var.location
}
