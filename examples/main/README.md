This is a deployment example for this module.

Prepare the environment by making sure you're logged in to with Azure CLI:
```bash
az login
```

Execute the following Terraform code:

```hcl
provider "azurerm" {
  features {}
}

module "control_plane" {
  source  = "terraform-aviatrix-modules/azure-controlplane/aviatrix"
  version = "1.0.0"

  controller_name               = "my_controller"
  incoming_ssl_cidr             = ["1.2.3.4"]
  controller_admin_email    = "admin@domain.com"
  controller_admin_password = "mysecretpassword"
  account_email                 = "admin@domain.com"
  access_account_name           = "Azure"
  customer_id          = "xxxxxxx-abu-xxxxxxxxx"
}

output "controlplane_data" {
  value = module.control_plane
}
```

This will create the following resources:
```
module.controlplane.module.azure_marketplace_agreement.azurerm_marketplace_agreement.controller_mp_agreement[0]
module.controlplane.module.azure_marketplace_agreement.azurerm_marketplace_agreement.copilot_mp_agreement[0]
module.controlplane.module.controller_build[0].azurerm_linux_virtual_machine.controller_vm
module.controlplane.module.controller_build[0].azurerm_network_interface.controller_nic
module.controlplane.module.controller_build[0].azurerm_network_interface_security_group_association.controller_nic_sg
module.controlplane.module.controller_build[0].azurerm_network_security_group.controller_nsg
module.controlplane.module.controller_build[0].azurerm_network_security_rule.controller_nsg_rule_https
module.controlplane.module.controller_build[0].azurerm_public_ip.controller_public_ip
module.controlplane.module.controller_build[0].azurerm_resource_group.controller_rg[0]
module.controlplane.module.controller_build[0].azurerm_subnet.controller_subnet[0]
module.controlplane.module.controller_build[0].azurerm_virtual_network.controller_vnet[0]
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