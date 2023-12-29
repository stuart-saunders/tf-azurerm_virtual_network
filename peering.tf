resource "azurerm_virtual_network_peering" "this" {
  for_each = local.peerings

  name                      = "${azurerm_virtual_network.this.name}_to_${each.key}"
  resource_group_name       = var.resource_group_name
  virtual_network_name      = azurerm_virtual_network.this.name
  remote_virtual_network_id = each.value.remote_virtual_network_id != null ? each.value.remote_virtual_network_id : data.azurerm_virtual_network.this[each.key].id
}