output "controller_public_ip_address" {
  value = var.use_existing_public_ip ? data.azurerm_public_ip.controller_public_ip[0].ip_address : azurerm_public_ip.controller_public_ip[0].ip_address
}

output "controller_private_ip_address" {
  value = azurerm_network_interface.controller_nic.private_ip_address
}

output "controller_rg_name" {
  value = var.use_existing_resource_group ? var.resource_group_name : azurerm_resource_group.controller_rg[0].name
}

output "controller_nsg" {
  value = azurerm_network_security_group.controller_nsg
}

output "controller_vnet_name" {
  value = var.use_existing_vnet ? var.vnet_name : azurerm_virtual_network.controller_vnet[0].name
}

output "controller_vnet_id" {
  value = var.use_existing_vnet ? null : azurerm_virtual_network.controller_vnet[0].guid
}

output "controller_subnet_name" {
  value = var.use_existing_vnet ? null : azurerm_subnet.controller_subnet[0].name
}

output "controller_subnet_id" {
  value = var.use_existing_vnet ? var.subnet_id : azurerm_subnet.controller_subnet[0].id
}

output "controller_name" {
  value = azurerm_linux_virtual_machine.controller_vm.name
}

output "controller_vm_id" {
  value = azurerm_linux_virtual_machine.controller_vm.virtual_machine_id
}

output "location" {
  value = var.location
}

output "storage_account_name" {
  value = var.create_storage_account ? azurerm_storage_account.controller[0].name : null
}

output "backup_container_name" {
  value = var.create_storage_account ? azurerm_storage_container.controller_backup[0].name : null
}

output "terraform_container_name" {
  value = var.create_storage_account ? azurerm_storage_container.terraform_state[0].name : null
}