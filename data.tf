data "azurerm_virtual_network" "this" {
  for_each = { 
    for peering in local.peerings :
      peering.remote_virtual_network_name => peering
    if peering.remote_virtual_network_id == null
  }

  name                = each.value.remote_virtual_network_name
  resource_group_name = each.value.remote_virtual_network_resource_group_name != null ? each.value.remote_virtual_network_resource_group_name : var.resource_group_name

  depends_on = [ 
    azurerm_virtual_network.this
  ]
}