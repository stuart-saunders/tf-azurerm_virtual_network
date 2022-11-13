# data "azurerm_client_config" "current" {}

data "azurerm_network_security_group" "this" {
  for_each = local.nsg_associations

  name                = each.value.nsg_name
  resource_group_name = each.value.nsg_rg_name
}

data "azurerm_route_table" "this" {
  for_each = local.route_table_associations

  name                = each.value.route_table_name
  resource_group_name = each.value.route_table_rg_name
}