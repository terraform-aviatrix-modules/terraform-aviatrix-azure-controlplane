This is a deployment example for this module.

Execute the following Terraform code:

```hcl
module "azure_marketplace_agreement" {
  source = "./modules/azure_marketplace_agreement"

  accept_controller_subscription = true #Default
  accept_copilot_subscription    = true #Default
}
```
