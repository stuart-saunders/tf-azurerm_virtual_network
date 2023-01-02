locals {

  vnets = { for vnet in var.vnets :
    vnet.name => vnet
  }

  subnets = merge([ for vnet in var.vnets :
    {
      for subnet in vnet.subnets :
      "${vnet.name}_${subnet.name}" => {
        vnet_name = vnet.name
        name = subnet.name
        address_prefixes = subnet.address_prefixes
        delegation = subnet.delegation
        private_endpoint_network_policies_enabled = subnet.private_endpoint_network_policies_enabled
        private_link_service_network_policies_enabled = subnet.private_link_service_network_policies_enabled
        service_endpoints = subnet.service_endpoints
        service_endpoint_policy_ids = subnet.service_endpoint_policy_ids
        nsgs = subnet.nsgs
        nsg_ids = subnet.nsg_ids
        route_tables = subnet.route_tables
        route_table_ids = subnet.route_table_ids
      }
    }
  ]...)

  nsg_ids = merge([ for subnet in local.subnets :
    {
      for id in subnet.nsg_ids :
        "${subnet.name}_${id}" => {
          nsg_id = id
          subnet_name = subnet.name
          vnet_name = subnet.vnet_name
        }
    }

  ]...)

  nsgs = { for nsg in var.nsgs :
    nsg.name => nsg
  }

  route_tables = { for table in var.route_tables :
    table.name => table
  }

}