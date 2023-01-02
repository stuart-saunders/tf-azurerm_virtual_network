variable "resource_group_name" {
  type        = string
  description = "The name the Resource Group in which to create the Virtual Network"
}

variable "resource_group_location" {
  type        = string
  description = "The Azure region in which the Resource Group should be created"
}

variable "vnets" {
  type = list(object({
    name = string
    address_space = list(string)
    location = optional(string, null)

    subnets = list(object({
      name = string
      address_prefixes = list(string)

      delegation = optional(object({
        name = optional(string, null)
        service_delegation = optional(object({
          name    = optional(string, null)
          actions = optional(list(string), null)
        }), null)
      }), null)

      private_endpoint_network_policies_enabled     = optional(bool, true)
      private_link_service_network_policies_enabled = optional(bool, true)

      service_endpoints           = optional(list(string), null)
      service_endpoint_policy_ids = optional(list(string), null)

      nsgs = optional(list(object({
        name = string
        rules = optional(list(object({
          name                       = string
          priority                   = string
          direction                  = string
          access                     = string
          protocol                   = string
          source_port_range          = string
          destination_port_range     = string
          source_address_prefix      = string
          destination_address_prefix = string
        })), null)
      })), null)

      nsg_ids = optional(list(string), [])
      
      route_tables = optional(list(object({
        name = string
        disable_bgp_route_propagation = optional(bool, false)

        routes = optional(list(object({
          name = string
          address_prefix = optional(string)
          next_hop_type  = optional(string)
        })), [])
      })), [])

      route_table_ids = optional(list(string), [])
    }))
  }))
  description = "The Virtual Networks to create"
}

variable "nsgs" {
  type = list(object({
    name = string
    rules = list(object({
        name                       = string
        priority                   = string
        direction                  = string
        access                     = string
        protocol                   = string
        source_port_range          = string
        destination_port_range     = string
        source_address_prefix      = string
        destination_address_prefix = string
      }))
  }))
  description = "The Network Security Groups created outside of the module"
}

variable "route_tables" {
  type = list(object({
    name = string
    disable_bgp_route_propagation = optional(bool, false)

    routes = list(object({
      name           = string
      address_prefix = string
      next_hop_type  = string
    }))
  }))
  description = "The Route Tables created outside of the module"
}