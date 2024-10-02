data "azurerm_public_ip" "controller_public_ip_address" {
  name                = azurerm_public_ip.controller_public_ip.name
  resource_group_name = var.use_existing_vnet ? var.resource_group_name : azurerm_resource_group.controller_rg[0].name
}

output "controller_public_ip_address" {
  value = data.azurerm_public_ip.controller_public_ip_address.ip_address
}

output "controller_private_ip_address" {
  value = azurerm_network_interface.controller_nic.private_ip_address
}

data "azurerm_resource_group" "rg" {
  name = var.use_existing_vnet ? var.resource_group_name : azurerm_resource_group.controller_rg[0].name
}

output "controller_rg" {
  value = var.use_existing_vnet ? data.azurerm_resource_group.rg : azurerm_resource_group.controller_rg[0]
}

output "controller_nsg" {
  value = azurerm_network_security_group.controller_nsg
}

data "azurerm_virtual_network" "vnet" {
  name                = var.use_existing_vnet ? var.vnet_name : azurerm_virtual_network.controller_vnet[0].name
  resource_group_name = var.use_existing_vnet ? var.resource_group_name : azurerm_resource_group.controller_rg[0].name
}

output "controller_vnet" {
  value = data.azurerm_virtual_network.vnet
}

data "azurerm_subnet" "subnet" {
  name                 = var.use_existing_vnet ? var.subnet_name : azurerm_subnet.controller_subnet[0].name
  virtual_network_name = var.use_existing_vnet ? var.vnet_name : azurerm_virtual_network.controller_vnet[0].name
  resource_group_name  = var.use_existing_vnet ? var.resource_group_name : azurerm_resource_group.controller_rg[0].name
}

output "controller_subnet" {
  value = data.azurerm_subnet.subnet
}

output "controller_name" {
  value = azurerm_linux_virtual_machine.controller_vm.name
}
