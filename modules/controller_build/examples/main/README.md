This is a deployment example for this module.

Execute the following Terraform code:

```hcl
module "controller_build" {
  source = "./modules/controller_build"
  // please do not use special characters such as `\/"[]:|<>+=;,?*@&~!#$%^()_{}'` in the controller_name
  controller_name                           = "my_controller"
  location                                  = "East US"
  controller_vnet_cidr                      = "10.0.0.0/24"
  controller_subnet_cidr                    = "10.0.0.0/24"
  controller_virtual_machine_admin_username = "avxadmin"
  controller_virtual_machine_admin_password = "my_password"
  incoming_ssl_cidrs                        = ["1.2.3.4/32"]
}
```