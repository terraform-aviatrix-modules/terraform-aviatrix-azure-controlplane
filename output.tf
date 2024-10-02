output "controller_public_ip" {
  value = var.module_config.controller_deployment ? module.aviatrix_controller_build[0].aviatrix_controller_public_ip_address : null
}

output "controller_private_ip" {
  value = var.module_config.controller_deployment ? module.aviatrix_controller_build[0].aviatrix_controller_private_ip_address : null
}

output "copilot_public_ip" {
  value = var.module_config.copilot_deployment ? module.copilot_build_azure[0].public_ip : null
}

output "copilot_private_ip" {
  value = var.module_config.copilot_deployment ? module.copilot_build_azure[0].private_ip : null
}
