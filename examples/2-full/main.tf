resource "azurerm_resource_group" "this" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

resource "azurerm_network_security_group" "this" {
  name                = "nsg0"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  security_rule {
    name                       = "rule0"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_route_table" "this" {
  name                          = "rt0"
  location                      = azurerm_resource_group.this.location
  resource_group_name           = azurerm_resource_group.this.name
  disable_bgp_route_propagation = false

  route {
    name           = "route0"
    address_prefix = "10.1.0.0/16"
    next_hop_type  = "VnetLocal"
  }

  tags = {
    environment = "Dev"
  }
}

module "vnet" {
  source = "../../"

  virtual_network_name = var.virtual_network_name
  address_space        = var.address_space

  resource_group_name     = azurerm_resource_group.this.name
  resource_group_location = azurerm_resource_group.this.location

  subnets = var.subnets

  depends_on = [
    azurerm_network_security_group.this,
    azurerm_route_table.this
  ]
}