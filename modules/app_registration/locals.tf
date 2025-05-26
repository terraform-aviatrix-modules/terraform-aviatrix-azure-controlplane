locals {
  read_only_role = jsondecode(file("${path.module}/read_only_role.json"))
  service        = jsondecode(file("${path.module}/service_role.json"))
  service_role = (
    length(var.aviatrix_rgs) == 0 ? // Add RG permissions for subscription based IAM enforcement
    merge(local.service, { Actions = concat(local.service.Actions, ["Microsoft.Resources/subscriptions/resourceGroups/*"]) }) :
    local.service
  )
  transit_role  = jsondecode(file("${path.module}/transit_gw_addon.json"))
  backup_role   = jsondecode(file("${path.module}/backup_addon.json"))
  controller_rg = "/subscriptions/${split("/", local.subscription_ids_full[0])[2]}/resourceGroups/${var.controller_rg}"
  subscription_ids_full = (
    length(var.subscription_ids) > 0 ?
    [for v in var.subscription_ids : "/subscriptions/${v}"] :
    [data.azurerm_subscription.main.id]
  )
  aviatrix_rgs_full = flatten([
    for sub, rgs in var.aviatrix_rgs : [
      for rg in rgs : "/subscriptions/${sub}/resourceGroups/${rg}"
    ]
  ])
}