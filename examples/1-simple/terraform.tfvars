resource_group_name     = "rg-vnet-module-test"
resource_group_location = "uksouth"

virtual_network_name = "vnet0"
address_space        = ["10.0.0.0/16"]

subnets = [
  {
    name             = "subnet0"
    address_prefixes = ["10.0.0.0/24"]
  },
  {
    name             = "subnet1"
    address_prefixes = ["10.0.1.0/24"]
  }
]