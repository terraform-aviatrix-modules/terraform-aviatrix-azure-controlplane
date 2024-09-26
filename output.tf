output "controller_public_ip" {
  value = module.aviatrix_controller_build.aviatrix_controller_public_ip_address
}

output "controller_private_ip" {
  value = module.aviatrix_controller_build.aviatrix_controller_private_ip_address
}

output "copilot_public_ip" {
  value = var.build_copilot ? module.copilot_build_azure[0].public_ip : null
}

output "copilot_private_ip" {
  value = var.build_copilot ? module.copilot_build_azure[0].private_ip : null
}
