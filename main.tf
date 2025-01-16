#Accept Marketplace Agreement
module "azure_marketplace_agreement" {
  source = "./modules/azure_marketplace_agreement"

  accept_controller_subscription = var.module_config.accept_controller_subscription
  accept_copilot_subscription    = var.module_config.accept_copilot_subscription
  environment                    = var.environment #For internal use only
}

module "controller_build" {
  count = var.module_config.controller_deployment ? 1 : 0

  source = "./modules/controller_build"
  // please do not use special characters such as `\/"[]:|<>+=;,?*@&~!#$%^()_{}'` in the controller_name
  controller_name                           = var.controller_name
  location                                  = var.location
  controller_vnet_cidr                      = var.controlplane_vnet_cidr
  controller_subnet_cidr                    = var.controlplane_subnet_cidr
  controller_virtual_machine_admin_username = var.controller_virtual_machine_admin_username
  controller_virtual_machine_admin_password = var.controller_virtual_machine_admin_password
  controller_virtual_machine_size           = var.controller_virtual_machine_size
  incoming_ssl_cidrs                        = local.controller_allowed_cidrs
  use_existing_vnet                         = var.use_existing_vnet
  resource_group_name                       = var.resource_group_name
  vnet_name                                 = var.vnet_name
  subnet_name                               = var.subnet_name
  subnet_id                                 = var.subnet_id
  environment                               = var.environment #For internal use only

  depends_on = [
    module.azure_marketplace_agreement
  ]
}

module "controller_init" {
  count = var.module_config.controller_initialization ? 1 : 0

  source  = "terraform-aviatrix-modules/controller-init/aviatrix"
  version = "v1.0.4"

  controller_public_ip      = module.controller_build[0].controller_public_ip_address
  controller_private_ip     = module.controller_build[0].controller_private_ip_address
  controller_admin_email    = var.controller_admin_email
  controller_admin_password = var.controller_admin_password
  customer_id               = var.customer_id
  wait_for_setup_duration   = "0s"

  depends_on = [
    module.controller_build
  ]
}

#Copilot
module "copilot_build" {
  count = var.module_config.copilot_deployment ? 1 : 0

  source = "./modules/copilot_build"

  use_existing_vnet   = true
  resource_group_name = module.controller_build[0].controller_rg_name
  subnet_id           = module.controller_build[0].controller_subnet_id

  controller_public_ip           = module.controller_build[0].controller_public_ip_address
  controller_private_ip          = module.controller_build[0].controller_private_ip_address
  copilot_name                   = var.copilot_name
  virtual_machine_admin_username = var.controller_virtual_machine_admin_username
  virtual_machine_admin_password = local.virtual_machine_admin_password
  virtual_machine_size           = var.copilot_virtual_machine_size
  default_data_disk_size         = "100"
  location                       = var.location
  environment                    = var.environment #For internal use only

  allowed_cidrs = {
    "tcp_cidrs" = {
      priority = "100"
      protocol = "Tcp"
      ports    = ["443"]
      cidrs    = var.incoming_ssl_cidrs
    }
    "udp_cidrs" = {
      priority = "200"
      protocol = "Udp"
      ports    = ["5000", "31283"]
      cidrs    = [module.controller_build[0].controller_public_ip_address]
    }
  }

  additional_disks = {}

  depends_on = [
    module.azure_marketplace_agreement
  ]
}

module "copilot_init" {
  count = var.module_config.copilot_initialization ? 1 : 0

  source  = "terraform-aviatrix-modules/copilot-init/aviatrix"
  version = "v1.0.5"

  controller_public_ip             = module.controller_build[0].controller_public_ip_address
  controller_admin_password        = var.controller_admin_password
  copilot_public_ip                = module.copilot_build[0].public_ip
  service_account_email            = var.controller_admin_email
  copilot_service_account_password = local.virtual_machine_admin_password

  depends_on = [
    module.controller_init
  ]
}

#Account onboarding

#Create app registration
module "app_registration" {
  count              = var.module_config.app_registration ? 1 : 0
  source             = "./modules/app_registration"
  app_name           = var.app_name
  create_custom_role = var.create_custom_role
}

#Onboard the account
module "account_onboarding" {
  count  = var.module_config.account_onboarding ? 1 : 0
  source = "./modules/account_onboarding"

  controller_public_ip      = module.controller_build[0].controller_public_ip_address
  controller_admin_password = var.controller_admin_password

  access_account_name = var.access_account_name
  account_email       = var.account_email
  arm_subscription_id = module.app_registration[0].subscription_id
  arm_directory_id    = module.app_registration[0].directory_id
  arm_client_id       = module.app_registration[0].client_id
  arm_application_key = module.app_registration[0].application_key

  depends_on = [
    module.controller_init,
    module.app_registration
  ]
}
