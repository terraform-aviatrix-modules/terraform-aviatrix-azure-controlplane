This example shows how to use your own VNET for deployment of the Aviatrix Controlplane.

Prepare the environment by making sure you're logged in to with Azure CLI:
```bash
az login
```

Execute the following Terraform code:
```hcl
provider "azurerm" {
  features {}
  skip_provider_registration = true
}

variable "region" {
  default = "West Europe"
}

variable "rg_name" {
  default = "Aviatrix-Controlplane-RG"
}

variable "vnet_name" {
  default = "Aviatrix-Controlplane-VNET"
}

variable "subnet_name" {
  default = "Aviatrix-Controlplane-Subnet"
}

variable "vnet_cidr" {
  default = "10.0.0.0/22"
}

resource "azurerm_resource_group" "this" {
  name     = var.rg_name
  location = var.region
}

module "vnet" {
  source              = "Azure/vnet/azurerm"
  vnet_name           = var.vnet_name
  vnet_location       = var.region
  use_for_each        = true
  resource_group_name = azurerm_resource_group.this.name
  address_space       = [var.vnet_cidr] #Use a separate CIDR for gateways, to optimize usable IP space for workloads.
  subnet_prefixes = [
    cidrsubnet(var.vnet_cidr, 3, 0),
  ]
  subnet_names = [
    var.subnet_name,
  ]

  depends_on = [
    azurerm_resource_group.this
  ]
}

module "control_plane" {
  source  = "terraform-aviatrix-modules/azure-controlplane/aviatrix"
  version = "1.1.4"

  controller_name           = "my_controller"
  incoming_ssl_cidrs        = ["1.2.3.4"]
  controller_admin_email    = "admin@domain.com"
  controller_admin_password = "mysecretpassword"
  account_email             = "admin@domain.com"
  access_account_name       = "Azure"
  customer_id               = "xxxxxxx-abu-xxxxxxxxx"
  location                  = var.region

  use_existing_vnet   = true
  resource_group_name = azurerm_resource_group.this.name
  subnet_id           = module.vnet.vnet_subnets[0]
  vnet_name           = var.vnet_name
  subnet_name         = var.subnet_name

  depends_on = [module.vnet]
}

output "controlplane_data" {
  value = module.control_plane
}
```

```
module.controlplane.module.azure_marketplace_agreement.azurerm_marketplace_agreement.controller_mp_agreement[0]
module.controlplane.module.azure_marketplace_agreement.azurerm_marketplace_agreement.copilot_mp_agreement[0]
module.controlplane.module.controller_build[0].azurerm_linux_virtual_machine.controller_vm
module.controlplane.module.controller_build[0].azurerm_network_interface.controller_nic
module.controlplane.module.controller_build[0].azurerm_network_interface_security_group_association.controller_nic_sg
module.controlplane.module.controller_build[0].azurerm_network_security_group.controller_nsg
module.controlplane.module.controller_build[0].azurerm_network_security_rule.controller_nsg_rule_https
module.controlplane.module.controller_build[0].azurerm_public_ip.controller_public_ip
module.controlplane.module.controller_init[0].terracurl_request.controller_initial_setup
module.controlplane.module.controller_init[0].terracurl_request.first_controller_login
module.controlplane.module.controller_init[0].terracurl_request.set_admin_email
module.controlplane.module.controller_init[0].terracurl_request.set_admin_password
module.controlplane.module.controller_init[0].terracurl_request.set_customer_id
module.controlplane.module.controller_init[0].terracurl_request.set_notification_email
module.controlplane.module.controller_init[0].terracurl_request.verify_complete
module.controlplane.module.controller_init[0].time_sleep.wait_for_setup
module.controlplane.module.copilot_build[0].azurerm_linux_virtual_machine.copilot_vm[0]
module.controlplane.module.copilot_build[0].azurerm_managed_disk.default[0]
module.controlplane.module.copilot_build[0].azurerm_network_interface.copilot_nic
module.controlplane.module.copilot_build[0].azurerm_network_interface_security_group_association.example
module.controlplane.module.copilot_build[0].azurerm_network_security_group.copilot_nsg
module.controlplane.module.copilot_build[0].azurerm_public_ip.copilot_public_ip[0]
module.controlplane.module.copilot_build[0].time_sleep.sleep_10min[0]
module.controlplane.module.copilot_init[0].terracurl_request.add_access_accounts_to_rbac_group
module.controlplane.module.copilot_init[0].terracurl_request.add_copilot_service_account
module.controlplane.module.copilot_init[0].terracurl_request.add_permission_group
module.controlplane.module.copilot_init[0].terracurl_request.add_permissions_to_rbac_group
module.controlplane.module.copilot_init[0].terracurl_request.configure_netflow
module.controlplane.module.copilot_init[0].terracurl_request.configure_syslog
module.controlplane.module.copilot_init[0].terracurl_request.copilot_init_simple
module.controlplane.module.copilot_init[0].terracurl_request.enable_copilot_association
```