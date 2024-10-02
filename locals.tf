locals {
  virtual_machine_admin_password = var.virtual_machine_admin_password != "" ? var.virtual_machine_admin_password : var.controller_admin_password

  copilot_public_ip        = var.module_config.copilot_deployment ? module.copilot_build_azure[0].public_ip : null
  controller_allowed_cidrs = concat(var.incoming_ssl_cidr, [local.copilot_public_ip])
}
