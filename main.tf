#Accept M<arketplace Agreement
module "aviatrix_azure_marketplace_agreement" {
  count  = var.use_existing_mp_agreement ? 0 : 1
  source = "./modules/aviatrix_azure_marketplace_agreement"
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
  incoming_ssl_cidr                         = local.controller_allowed_cidrs
  use_existing_vnet                         = var.use_existing_vnet
  resource_group_name                       = var.resource_group_name
  vnet_name                                 = var.vnet_name
  subnet_name                               = var.subnet_name
  subnet_id                                 = var.subnet_id

  depends_on = [
    module.aviatrix_azure_marketplace_agreement
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

#Account onboarding
#Create app registration
module "aviatrix_controller_azure" {
  count              = 0
  source             = "./modules/aviatrix_controller_azure"
  app_name           = var.app_name
  create_custom_role = var.create_custom_role

  depends_on = [
    module.aviatrix_controller_build
  ]
}


#Copilot
module "copilot_build_azure" {
  count = var.build_copilot ? 1 : 0

  source = "./modules/copilot_build_azure"

  use_existing_vnet   = true
  resource_group_name = module.aviatrix_controller_build.aviatrix_controller_rg.name
  subnet_id           = module.aviatrix_controller_build.aviatrix_controller_subnet.id

  controller_public_ip           = module.aviatrix_controller_build.aviatrix_controller_public_ip_address
  controller_private_ip          = module.aviatrix_controller_build.aviatrix_controller_private_ip_address
  copilot_name                   = local.copilot_name
  virtual_machine_admin_username = var.controller_virtual_machine_admin_username
  virtual_machine_admin_password = local.virtual_machine_admin_password
  default_data_disk_size         = "100"

  allowed_cidrs = {
    "tcp_cidrs" = {
      priority = "100"
      protocol = "Tcp"
      ports    = ["443"]
      cidrs    = var.incoming_ssl_cidr
    }
    "udp_cidrs" = {
      priority = "200"
      protocol = "Udp"
      ports    = ["5000", "31283"]
      cidrs    = module.aviatrix_controller_build.aviatrix_controller_public_ip_address
    }
  }

  additional_disks = {}

  depends_on = [
    module.aviatrix_azure_marketplace_agreement
  ]
}

module "copilot_init" {
  count = var.build_copilot ? 1 : 0

  source  = "terraform-aviatrix-modules/copilot-init/aviatrix"
  version = "v1.0.1"

  avx_controller_public_ip         = module.aviatrix_controller_build.aviatrix_controller_public_ip_address
  avx_controller_admin_password    = var.avx_controller_admin_password
  avx_copilot_public_ip            = module.copilot_build_azure[0].public_ip
  service_account_email            = var.avx_controller_admin_email
  copilot_service_account_password = local.virtual_machine_admin_password

  depends_on = [
    module.controller_init
  ]
}
