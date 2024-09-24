module "aviatrix_controller_azure" {
  count                     = 0
  source                    = "./modules/aviatrix_controller_azure"
  app_name                  = var.app_name
  create_custom_role        = var.create_custom_role
  use_existing_mp_agreement = var.use_existing_mp_agreement
}

module "aviatrix_controller_build" {
  source = "./modules/aviatrix_controller_build"
  // please do not use special characters such as `\/"[]:|<>+=;,?*@&~!#$%^()_{}'` in the controller_name
  controller_name                           = var.controller_name
  location                                  = var.location
  controller_vnet_cidr                      = var.controller_vnet_cidr
  controller_subnet_cidr                    = var.controller_subnet_cidr
  controller_virtual_machine_admin_username = var.controller_virtual_machine_admin_username
  controller_virtual_machine_admin_password = var.controller_virtual_machine_admin_password
  controller_virtual_machine_size           = var.controller_virtual_machine_size
  incoming_ssl_cidr                         = var.incoming_ssl_cidr
  use_existing_vnet                         = var.use_existing_vnet
  resource_group_name                       = var.resource_group_name
  vnet_name                                 = var.vnet_name
  subnet_name                               = var.subnet_name
  subnet_id                                 = var.subnet_id

  depends_on = [
    module.aviatrix_controller_azure
  ]
}

module "controller_init" {
  source  = "terraform-aviatrix-modules/controller-init/aviatrix"
  version = "v1.0.0"

  avx_controller_public_ip      = module.aviatrix_controller_build.aviatrix_controller_public_ip_address
  avx_controller_private_ip     = module.aviatrix_controller_build.aviatrix_controller_private_ip_address
  avx_controller_admin_email    = var.avx_controller_admin_email
  avx_controller_admin_password = var.avx_controller_admin_password
  aviatrix_customer_id          = var.aviatrix_customer_id

  depends_on = [
    module.aviatrix_controller_build
  ]
}
