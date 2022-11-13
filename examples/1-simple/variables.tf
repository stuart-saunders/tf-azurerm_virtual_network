variable "resource_group_name" {
  type        = string
  description = "The name the Resource Group in which to create the Virtual Network"
}

variable "resource_group_location" {
  type        = string
  description = "The Azure region in which the Resource Group should be created"
}

variable "virtual_network_name" {
  type        = string
  description = "The name of the Virtual Network to create"
}

variable "address_space" {
  type        = list(string)
  description = "The list of address spaces used by the Virtual Network"
}

variable "subnets" {
  type = list(object({
    name             = string
    address_prefixes = list(string)
    delegation = optional(list(object({
      name = string
      service_delegation = object({
        name    = string
        actions = list(string)
      })
    })), [])
    private_endpoint_network_policies_enabled     = optional(bool, true)
    private_link_service_network_policies_enabled = optional(bool, true)
    service_endpoints                             = optional(list(string), null)
    service_endpoint_policy_ids                   = optional(list(string), null)
    nsg_ids                                       = optional(list(string), [])
    route_table_ids                               = optional(list(string), [])
  }))
  description = "The Subnet(s) to create within the Virtual Network"
}