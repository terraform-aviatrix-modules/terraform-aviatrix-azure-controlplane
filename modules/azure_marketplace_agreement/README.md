<!-- BEGIN_TF_DOCS -->
# terraform-aviatrix-azure-controlplane - marketplace-agreement

### Description
This submodule helps with subscribing to the Aviatrix marketplace offerings.

### Usage Example
```hcl
module "azure_marketplace_agreement" {
  source = "./modules/azure_marketplace_agreement"

  accept_controller_subscription = true #Default
  accept_copilot_subscription    = true #Default
}
```
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_accept_controller_subscription"></a> [accept\_controller\_subscription](#input\_accept\_controller\_subscription) | Toggles the acceptance of the Controller subscription | `bool` | `true` | no |
| <a name="input_accept_copilot_subscription"></a> [accept\_copilot\_subscription](#input\_accept\_copilot\_subscription) | Toggles the acceptance of the copilot subscription | `bool` | `true` | no |
| <a name="input_cloud_type"></a> [cloud\_type](#input\_cloud\_type) | Determines which cloud should we subscribe offer | `string` | `"commercial"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->