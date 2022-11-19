locals {

  subnets = { for value in var.subnets :
    value.name => value
  }

  nsgs = merge([for subnet_value in local.subnets :
    {
      for nsg_value in subnet_value.nsgs :
        "${subnet_value.name}_${nsg_value.name}" => {
          subnet_name = subnet_value.name
          nsg_name    = nsg_value.name
          # nsg_rg_name = nsg_value.resource_group_name
          nsg_rules   = nsg_value.rules
      }
    }
  ]...)

  nsg_rules = merge([for nsg_key, nsg_value in local.nsgs :
    {
      for rule_value in nsg_value.nsg_rules :
        "${nsg_value.name}_${rule_value.name}" => {
          subnet_name = subnet_value.name
          nsg_key     = nsg_key
          nsg_name    = nsg_value.name
          rule_name   = rule_value.name
          priority    = rule_value.priority
          direction = rule_value.direction
          access = rule_value.access
          protocol = rule_value.protocol
          source_port_range = rule_value.source_port_range
          destination_port_range = rule_value.destination_port_range
          source_address_prefix = rule_value.source_address_prefix
          destination_address_prefix = rule_value.destination_address_prefix
      }
    }
  ]...)

  route_table_associations = merge([for subnet_value in local.subnets :
    {
      for rt_value in subnet_value.route_tables :
        "${subnet_value.name}_${rt_value.name}" => {
          subnet_name    = subnet_value.name
          route_table_name = rt_value.name
          route_table_rg_name = rt_value.resource_group_name
      }
    }
  ]...)

}