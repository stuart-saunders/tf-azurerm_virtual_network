resource "azurerm_resource_group" "this" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

module "vnet" {
  for_each = local.vnets
  source   = "../../"

  name          = each.value.name
  address_space = each.value.address_space

  resource_group_name     = azurerm_resource_group.this.name
  resource_group_location = azurerm_resource_group.this.location

  subnets = each.value.subnets
}