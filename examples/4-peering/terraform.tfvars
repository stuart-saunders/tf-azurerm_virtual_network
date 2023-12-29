resource_group_name = "rg-vnet-module-example-4"
location            = "uksouth"

vnets = [
  {
    name          = "example4-hub"
    address_space = ["10.0.0.0/16"]

    peerings = [ 
      {
        remote_virtual_network_name = "example4-spoke1"
      },
      {
        remote_virtual_network_name = "example4-spoke2"
      },
      {
        remote_virtual_network_name = "example4-vnet-existing"
        remote_virtual_network_id = "/subscriptions/ca630ab5-4a89-4ed5-93f7-c6c78e624eb3/resourceGroups/rg-vnet-module-example-4/providers/Microsoft.Network/virtualNetworks/example4-vnet-existing"
      }
    ]

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
  },
  {
    name          = "example4-spoke1"
    address_space = ["10.1.0.0/16"]

    peerings = [ 
      {
        remote_virtual_network_name = "example4-hub"
      },
    ]

    subnets = [
      {
        name             = "subnet0"
        address_prefixes = ["10.1.0.0/24"]
      },
      {
        name             = "subnet1"
        address_prefixes = ["10.1.1.0/24"]
      }
    ]
  },
  {
    name          = "example4-spoke2"
    address_space = ["10.2.0.0/16"]

    peerings = [ 
      {
        remote_virtual_network_name = "example4-hub"
      },
    ]

    subnets = [
      {
        name             = "subnet0"
        address_prefixes = ["10.2.0.0/24"]
      },
      {
        name             = "subnet1"
        address_prefixes = ["10.2.1.0/24"]
      }
    ]
  }
]