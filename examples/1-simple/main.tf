resource "azurerm_resource_group" "this" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

module "vnet" {
  source = "../../"

  virtual_network_name = var.virtual_network_name
  address_space        = var.address_space

  resource_group_name     = azurerm_resource_group.this.name
  resource_group_location = azurerm_resource_group.this.location

  subnets = var.subnets
}