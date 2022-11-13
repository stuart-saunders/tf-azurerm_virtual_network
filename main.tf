resource "azurerm_virtual_network" "this" {
  name                = var.virtual_network_name
  location            = var.virtual_network_location != null ? var.virtual_network_location : var.resource_group_location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space

  edge_zone               = var.edge_zone
  flow_timeout_in_minutes = var.flow_timeout_in_minutes

  dynamic "ddos_protection_plan" {
    for_each = var.ddos_protection_plan.id != null ? [1] : []

    content {
      enable = var.ddos_protection_plan.enable
      id     = var.ddos_protection_plan.id
    }
  }

  tags = var.tags
}

resource "azurerm_virtual_network_dns_servers" "this" {
  count = length(var.dns_servers) > 0 ? 1 : 0

  virtual_network_id = azurerm_virtual_network.this.id
  dns_servers        = var.dns_servers
}

resource "azurerm_subnet" "this" {
  for_each = local.subnets

  name                 = each.value.name
  resource_group_name  = azurerm_virtual_network.this.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = each.value.address_prefixes

  dynamic "delegation" {
    for_each = each.value.delegation != null ? [1] : []

    content {
      name = each.value.delegation.name
      service_delegation {
        name    = each.value.delegation.service_delegation.name
        actions = each.value.delegation.service_delegation.actions
      }
    }
  }

  private_endpoint_network_policies_enabled     = each.value.private_endpoint_network_policies_enabled
  private_link_service_network_policies_enabled = each.value.private_link_service_network_policies_enabled

  service_endpoints = each.value.service_endpoints
  #service_endpoint_policy_ids = each.value.service_endpoint_policy_ids
}

resource "azurerm_subnet_network_security_group_association" "this" {
  for_each = local.nsg_associations

  network_security_group_id = data.azurerm_network_security_group.this[each.key].id
  subnet_id                 = azurerm_subnet.this[each.value.subnet_name].id
}

resource "azurerm_subnet_route_table_association" "vnet" {
  for_each = local.route_table_associations

  route_table_id = data.azurerm_route_table.this[each.key].id
  subnet_id      = azurerm_subnet.this[each.value.subnet_name].id
}