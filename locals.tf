locals {
  copilot_name                   = var.copilot_name != "" ? var.copilot_name : "test123"
  virtual_machine_admin_password = var.virtual_machine_admin_password != "" ? var.virtual_machine_admin_password : var.avx_controller_admin_password

  copilot_public_ip        = var.build_copilot ? module.copilot_build_azure[0].public_ip : null
  controller_allowed_cidrs = concat(var.incoming_ssl_cidr, [local.copilot_public_ip])
}
