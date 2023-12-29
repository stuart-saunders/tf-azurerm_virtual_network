resource "azurerm_virtual_network" "existing" {
  name                = "example4-vnet-existing"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = ["10.99.0.0/16"]
}

resource "azurerm_subnet" "existing" {
  name                 = "example4-subnet-existing"
  resource_group_name  = azurerm_virtual_network.existing.resource_group_name
  virtual_network_name = azurerm_virtual_network.existing.name
  address_prefixes     = ["10.99.0.0/24"]
}