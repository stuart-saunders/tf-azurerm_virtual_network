locals {

  peerings = { for peering in var.peerings : 
    peering.remote_virtual_network_name => peering
  }

  subnets = { for subnet in var.subnets :
    subnet.name => subnet
  }

  nsgs = merge([for subnet_key, subnet in local.subnets :
    {
      for nsg in subnet.nsgs :
      "${subnet_key}_${nsg.name}" => {
        name        = nsg.name
        subnet_name = subnet.name
        rules       = nsg.rules
      }
    }
  ]...)

  nsg_rules = merge([for nsg_key, nsg in local.nsgs :
    {
      for rule in nsg.rules :
      "${nsg.name}_${rule.name}" => {
        subnet_name                = nsg.subnet_name
        nsg_key                    = nsg_key
        nsg_name                   = nsg.name
        name                       = rule.name
        priority                   = rule.priority
        direction                  = rule.direction
        access                     = rule.access
        protocol                   = rule.protocol
        source_port_range          = rule.source_port_range
        destination_port_range     = rule.destination_port_range
        source_address_prefix      = rule.source_address_prefix
        destination_address_prefix = rule.destination_address_prefix
      }
    }
  ]...)

  nsg_ids = merge([ for subnet_key, subnet in local.subnets : 
    {
      for id in subnet.nsg_ids :
        "${id}_${subnet_key}" => {
          id = id
          subnet_name = subnet.name
        }
    }
  ]...)

  route_tables = merge([for subnet_key, subnet in local.subnets :
    {
      for table in subnet.route_tables :
      "${subnet_key}_${table.name}" => {
        subnet_name                   = subnet.name
        name                          = table.name
        disable_bgp_route_propagation = table.disable_bgp_route_propagation
        routes                        = table.routes
      }
    }
  ]...)

  routes = merge([for table_key, table in local.route_tables :
    {
      for route_key, route in table.routes :
      "${table_key}_${route.name}" => {
        subnet_name     = table.subnet_name
        route_table_key = table_key
        name            = route.name
        address_prefix  = route.address_prefix
        next_hop_type   = route.next_hop_type
      }
    }
  ]...)

  route_table_ids = merge([ for subnet_key, subnet in local.subnets : 
    {
      for id in subnet.route_table_ids :
        "${id}_${subnet_key}" => {
          id = id
          subnet_name = subnet.name
        }
    }
  ]...)

}