resource "azurerm_resource_group" "this" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

module "vnet" {
  source = "../../"

  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location

  name          = var.vnet.name
  address_space = var.vnet.address_space
  subnets       = var.vnet.subnets

}