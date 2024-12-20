This is a deployment example for this module.

Execute the following Terraform code:

```hcl
module "app_registration" {
  source   = "./modules/app_registration"
  app_name = "my_controller"
}
```
