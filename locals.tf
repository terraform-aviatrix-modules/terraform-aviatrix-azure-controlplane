locals {
  virtual_machine_admin_password = var.virtual_machine_admin_password != "" ? var.virtual_machine_admin_password : var.controller_admin_password

  copilot_public_ip        = var.module_config.copilot_deployment ? [module.copilot_build[0].public_ip] : []
  copilot_private_ip       = var.module_config.copilot_deployment ? [module.copilot_build[0].private_ip] : []
  copilot_ips              = concat(local.copilot_private_ip, local.copilot_public_ip)
  controller_allowed_cidrs = concat(var.incoming_ssl_cidrs, local.copilot_ips)
}
