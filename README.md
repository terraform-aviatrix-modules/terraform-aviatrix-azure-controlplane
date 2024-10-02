# terraform-aviatrix-azure-controlplane

### Description
This module deploys the Aviatrix control plane, or individual parts thereof.

### Requirements
This module assumes you have Azure CLI installed and are authenticated with sufficient privileges.

### Compatibility
Module version | Terraform version
:--- | :---
v1.0.0 | >= 1.3.0

### Usage Example
```hcl
provider "azurerm" {
  features {}
}

module "control_plane" {
  source  = "terraform-aviatrix-modules/azure-controlplane/aviatrix"
  version = "1.0.0"

  controller_name               = "my_controller"
  incoming_ssl_cidr             = ["1.2.3.4"]
  avx_controller_admin_email    = "admin@domain.com"
  avx_controller_admin_password = "mysecretpassword"
  account_email                 = "admin@domain.com"
  access_account_name           = "Azure"
  aviatrix_customer_id          = "xxxxxxx-abu-xxxxxxxxx"
}

output "controlplane_data" {
  value = module.control_plane
}
```

### Variables
The following variables are required:

key | value
:--- | :---
\<keyname> | \<description of value that should be provided in this variable>

The following variables are optional:

key | default | value 
:---|:---|:---
module_config |  {
    accept_controller_subscription = true,
    accept_copilot_subscription    = true,
    app_registration               = true,
    account_onboarding             = true,
    controller_deployment          = true,
    controller_initialization      = true,
    copilot_deployment             = true,
    copilot_initialization         = true,
  } | Determines which submodules are activated.

### Outputs
This module will return the following outputs:

key | description
:---|:---
\<keyname> | \<description of object that will be returned in this output>
