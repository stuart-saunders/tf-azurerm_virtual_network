locals {

  subnets = { for value in var.subnets :
    value.name => value
  }

  nsg_associations = merge([for subnet_value in local.subnets :
    {
      for nsg_value in subnet_value.nsgs :
        "${subnet_value.name}_${nsg_value.name}" => {
          subnet_name = subnet_value.name
          nsg_name    = nsg_value.name
          nsg_rg_name = nsg_value.resource_group_name
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