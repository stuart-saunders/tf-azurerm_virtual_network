resource_group_name     = "rg-vnet-module-example-2"
resource_group_location = "uksouth"

vnets = [
  {
    name          = "example2-vnet0"
    address_space = ["10.0.0.0/16"]
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
    name          = "example2-vnet1"
    address_space = ["10.1.0.0/16"]
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
  }
]