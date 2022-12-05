locals {

  subnets = { for value in var.subnets :
    value.name => value
  }

  nsgs = merge([for subnet_value in local.subnets :
    {
      for nsg_value in subnet_value.nsgs :
      "${subnet_value.name}_${nsg_value.name}" => {
        subnet_name = subnet_value.name
        name        = nsg_value.name
        nsg_rules   = nsg_value.rules
      }
    }
  ]...)

  nsg_rules = merge([for nsg_key, nsg_value in local.nsgs :
    {
      for rule_value in nsg_value.nsg_rules :
      "${nsg_value.name}_${rule_value.name}" => {
        subnet_name                = nsg_value.subnet_name
        nsg_key                    = nsg_key
        nsg_name                   = nsg_value.name
        rule_name                  = rule_value.name
        priority                   = rule_value.priority
        direction                  = rule_value.direction
        access                     = rule_value.access
        protocol                   = rule_value.protocol
        source_port_range          = rule_value.source_port_range
        destination_port_range     = rule_value.destination_port_range
        source_address_prefix      = rule_value.source_address_prefix
        destination_address_prefix = rule_value.destination_address_prefix
      }
    }
  ]...)

  route_tables = merge([for subnet_value in local.subnets :
    {
      for table_value in subnet_value.route_tables :
      "${subnet_value.name}_${table_value.name}" => {
        subnet_name                   = subnet_value.name
        name                          = table_value.name
        disable_bgp_route_propagation = table_value.disable_bgp_route_propagation
        routes                        = table_value.routes
      }
    }
  ]...)

  routes = merge([for table_key, table_value in local.route_tables :
    {
      for route_value in table_value.routes :
      "${table_value.name}_${route_value.name}" => {
        subnet_name     = table_value.subnet_name
        route_table_key = table_key
        name            = route_value.name
        address_prefix  = route_value.address_prefix
        next_hop_type   = route_value.next_hop_type
      }
    }
  ]...)

}