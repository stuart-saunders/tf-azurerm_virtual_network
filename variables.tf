variable "resource_group_name" {
  type        = string
  description = "(Required) The name the Resource Group in which to create the Virtual Network"
}

variable "resource_group_location" {
  type        = string
  description = "(Required) The Azure region in which the Resource Group should be created"
}

variable "name" {
  type        = string
  description = "(Required) The name of the Virtual Network to create"
}

variable "location" {
  type        = string
  description = "(Optional) The Azure region in which the Virtual Network should be created"
  default     = null
}

variable "address_space" {
  type        = list(string)
  description = "(Required) The list of address spaces used by the Virtual Network"
}

variable "dns_servers" {
  type        = list(string)
  description = "(Optional) List of IP addresses of DNS servers"
  default     = []
}

variable "ddos_protection_plan" {
  type = object({
    enable = bool
    id     = string
  })
  description = "(Optional) Enables a DDoS Protection Plan on the Virtual Network"
  default = {
    enable = false
    id     = null
  }
}

variable "edge_zone" {
  type        = string
  description = "(Optional) The Edge Zone within the Azure Region where this Virtual Network should exist"
  default     = null
}

variable "flow_timeout_in_minutes" {
  type        = number
  description = "(Optional) The flow timeout in minutes for the Virtual Network, which is used to enable connection tracking for intra-VM flows. Possible values are between 4 and 30 minutes."
  default     = null
}

variable "subnets" {
  type = list(object({
    name             = string
    address_prefixes = list(string)

    delegation = optional(object({
      name = string
      service_delegation = object({
        name    = string
        actions = list(string)
      })
    }), null)

    private_endpoint_network_policies_enabled     = optional(bool, true)
    private_link_service_network_policies_enabled = optional(bool, true)

    service_endpoints           = optional(list(string), null)
    service_endpoint_policy_ids = optional(list(string), null)

    nsgs = optional(list(object({
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
    })), [])

    route_tables = optional(list(object({
      name                          = string
      disable_bgp_route_propagation = optional(bool, false)

      routes = list(object({
        name           = string
        address_prefix = string
        next_hop_type  = string
      }))
    })), [])

  }))
  description = "(Required) The Subnet(s) to create within the Virtual Network"
}

variable "tags" {
  type        = map(string)
  description = "(Optional) The list of tags to apply to the resources"
  default     = {}
}