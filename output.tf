output "controller_public_ip" {
  value = var.module_config.controller_deployment ? module.controller_build[0].controller_public_ip_address : null
}

output "controller_private_ip" {
  value = var.module_config.controller_deployment ? module.controller_build[0].controller_private_ip_address : null
}

output "copilot_public_ip" {
  value = var.module_config.copilot_deployment ? module.copilot_build[0].public_ip : null
}

output "copilot_private_ip" {
  value = var.module_config.copilot_deployment ? module.copilot_build[0].private_ip : null
}

output "directory_id" {
  value = var.module_config.app_registration ? module.app_registration[0].directory_id : null
}

output "client_id" {
  value = var.module_config.app_registration ? module.app_registration[0].client_id : null
}

output "application_key" {
  value = var.module_config.app_registration ? module.app_registration[0].application_key : null
}

output "storage_account_name" {
  value = var.module_config.controller_deployment && var.create_storage_account ? module.controller_build[0].storage_account_name : null
}

output "backup_container_name" {
  value = var.module_config.controller_deployment && var.create_storage_account ? module.controller_build[0].backup_container_name : null
}

output "terraform_container_name" {
  value = var.module_config.controller_deployment && var.create_storage_account ? module.controller_build[0].terraform_container_name : null
}

output "controller_vnet_name" {
  value = var.module_config.controller_deployment && !var.use_existing_vnet ? module.controller_build[0].controller_vnet_name : null
}

output "controller_vnet_id" {
  value = var.module_config.controller_deployment && !var.use_existing_vnet ? module.controller_build[0].controller_vnet_id : null
}

output "controller_rg_name" {
  value = var.module_config.controller_deployment && !var.use_existing_vnet ? module.controller_build[0].controller_rg_name : null
}

output "controller_name" {
  value = var.module_config.controller_deployment && !var.use_existing_vnet ? module.controller_build[0].controller_name : null
}

output "controller_vm_id" {
  value = var.module_config.controller_deployment && !var.use_existing_vnet ? module.controller_build[0].controller_vm_id : null
}