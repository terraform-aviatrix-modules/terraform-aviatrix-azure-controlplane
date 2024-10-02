## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |
| <a name="provider_http"></a> [http](#provider\_http) | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_marketplace_agreement.aviatrix_controller_mp_agreement](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/marketplace_agreement) | resource |
| [azurerm_marketplace_agreement.aviatrix_copilot_mp_agreement](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/marketplace_agreement) | resource |
| [http_http.controller_image_info](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [http_http.copilot_image_info](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_accept_controller_subscription"></a> [accept\_controller\_subscription](#input\_accept\_controller\_subscription) | Toggles the acceptance of the Controller subscription | `bool` | `true` | no |
| <a name="input_accept_copilot_subscription"></a> [accept\_copilot\_subscription](#input\_accept\_copilot\_subscription) | Toggles the acceptance of the copilot subscription | `bool` | `true` | no |

## Outputs

No outputs.
