output "Copilot_management_login" {
  value = var.module_config.copilot_deployment ? format("https://%s/", module.copilot_build[0].public_ip) : null
}

output "username" {
  value = "admin"
}

output "password" {
  value = var.controller_admin_password
}
