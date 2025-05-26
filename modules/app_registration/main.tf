/**
 * # Aviatrix Controller Azure
 *
 * This module builds the Azure Active Directory (AAD) Application and Service Principal.
 * If you already have an AAD Application you would like to use then you do not need to
 * use this module.
 */

data "azuread_client_config" "current" {}

# 1.Create the Azure AD APP
resource "azuread_application" "aviatrix_ad_app" {
  display_name = var.app_name
  owners       = [data.azuread_client_config.current.object_id]
}

# 2. Create the password for the created APP
resource "azuread_application_password" "aviatrix_app_password" {
  application_id = azuread_application.aviatrix_ad_app.id
  end_date       = timeadd(timestamp(), var.app_password_validity_length)

  lifecycle {
    ignore_changes = [end_date]
  }
}

# 3. Create SP associated with the APP
resource "azuread_service_principal" "aviatrix_sp" {
  client_id = azuread_application.aviatrix_ad_app.client_id
  owners    = [data.azuread_client_config.current.object_id]
}

# 4. Create the password for the created SP
resource "azuread_service_principal_password" "aviatrix_sp_password" {
  service_principal_id = azuread_service_principal.aviatrix_sp.id
}

# 5. Create a role assignment for the created SP
data "azurerm_subscription" "main" {}

# 6. Create a custom roles if var.create_custom_role = true
# Read only role assigned to all subscribtions with Aviatrix managed resources
resource "azurerm_role_definition" "aviatrix_read_only" {
  count = var.create_custom_role ? 1 : 0

  name        = var.aviatrix_role_names.read_only_name
  scope       = local.subscription_ids_full[0]
  description = local.read_only_role.Description

  permissions {
    actions          = local.read_only_role.Actions
    not_actions      = local.read_only_role.NotActions
    data_actions     = local.read_only_role.DataActions
    not_data_actions = local.read_only_role.NotDataActions
  }

  assignable_scopes = local.subscription_ids_full
}

# Service role allowing Aviatrix controller to modify resources
resource "azurerm_role_definition" "aviatrix_service" {
  count = var.create_custom_role ? 1 : 0

  name        = var.aviatrix_role_names.service_name
  scope       = length(var.aviatrix_rgs) == 0 ? local.subscription_ids_full[0] : local.controller_rg
  description = local.service_role.Description

  permissions {
    actions          = local.service_role.Actions
    not_actions      = local.service_role.NotActions
    data_actions     = local.service_role.DataActions
    not_data_actions = local.service_role.NotDataActions
  }

  assignable_scopes = length(var.aviatrix_rgs) == 0 ? local.subscription_ids_full : concat([local.controller_rg], local.aviatrix_rgs_full)
}

# Service role add-on allowing Aviatrix controller to backup its configuration into a storage account
resource "azurerm_role_definition" "aviatrix_backup" {
  count = var.create_custom_role ? 1 : 0

  name        = var.aviatrix_role_names.backup_name
  scope       = local.controller_rg
  description = local.backup_role.Description

  permissions {
    actions          = local.backup_role.Actions
    not_actions      = local.backup_role.NotActions
    data_actions     = local.backup_role.DataActions
    not_data_actions = local.backup_role.NotDataActions
  }

  assignable_scopes = [local.controller_rg]
}

# Service role add-on allowing Aviatrix controller to manage Azure ER connections
resource "azurerm_role_definition" "aviatrix_transits" {
  count = var.create_custom_role ? 1 : 0

  name        = var.aviatrix_role_names.transit_gw_name
  scope       = local.controller_rg
  description = local.transit_role.Description

  permissions {
    actions          = local.transit_role.Actions
    not_actions      = local.transit_role.NotActions
    data_actions     = local.transit_role.DataActions
    not_data_actions = local.transit_role.NotDataActions
  }

  assignable_scopes = [local.controller_rg]
}

#7. Assign roles to subscriptions or resource groups. 
resource "azurerm_role_assignment" "aviatrix_read_only" {
  for_each = var.create_custom_role ? toset(local.subscription_ids_full) : toset([])

  scope                = each.value
  role_definition_name = azurerm_role_definition.aviatrix_read_only[0].name
  principal_id         = azuread_service_principal.aviatrix_sp.object_id

  depends_on = [azurerm_role_definition.aviatrix_read_only] // apply fails first time on missing role, azure timing issue?
}

resource "azurerm_role_assignment" "aviatrix_service_subscription_level" {
  for_each = length(var.aviatrix_rgs) == 0 ? toset(local.subscription_ids_full) : toset([])

  scope                = each.value
  role_definition_name = var.create_custom_role ? azurerm_role_definition.aviatrix_service[0].name : "Contributor"
  principal_id         = azuread_service_principal.aviatrix_sp.object_id

  depends_on = [azurerm_role_definition.aviatrix_service]
}

resource "azurerm_role_assignment" "aviatrix_service_rg_level" {
  for_each = var.create_custom_role && length(var.aviatrix_rgs) > 0 ? toset(concat([local.controller_rg], local.aviatrix_rgs_full)) : toset([])

  scope                = each.value
  role_definition_name = azurerm_role_definition.aviatrix_service[0].name
  principal_id         = azuread_service_principal.aviatrix_sp.object_id

  depends_on = [azurerm_role_definition.aviatrix_service]
}

resource "azurerm_role_assignment" "aviatrix_transit_gw" { //Assumption: transits are in the same RG as the controller
  count = var.create_custom_role ? 1 : 0

  scope                = local.controller_rg
  role_definition_name = azurerm_role_definition.aviatrix_transits[0].name
  principal_id         = azuread_service_principal.aviatrix_sp.object_id

  depends_on = [azurerm_role_definition.aviatrix_transits]
}

resource "azurerm_role_assignment" "aviatrix_backup" {
  count = var.create_custom_role ? 1 : 0

  scope                = local.controller_rg
  role_definition_name = azurerm_role_definition.aviatrix_backup[0].name
  principal_id         = azuread_service_principal.aviatrix_sp.object_id

  depends_on = [azurerm_role_definition.aviatrix_backup]
}

