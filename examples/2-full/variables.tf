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
    
    delegation = optional(object({
      name = string
      service_delegation = object({
        name    = string
        actions = list(string)
      })
    }), null)

    private_endpoint_network_policies_enabled     = optional(bool, true)
    private_link_service_network_policies_enabled = optional(bool, true)
    
    service_endpoints                             = optional(list(string), null)
        
    nsgs = optional(list(object({
      name                = string
      resource_group_name = string
    })), [])

    route_tables = optional(list(object({
      name                = string
      resource_group_name = string
    })), [])
  }))
  description = "The Subnet(s) to create within the Virtual Network"
}

variable subnet_nsg_map {
  type = map(string)
  description = "A map of Subnet and NSG names"
  default = { }
}