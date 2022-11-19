resource_group_name     = "rg-vnet-module-test"
resource_group_location = "uksouth"

virtual_network_name = "vnet0"
address_space        = ["10.0.0.0/16"]

subnets = [
  {
    name             = "delegated-subnet"
    address_prefixes = ["10.0.0.0/24"]   
    delegation = {
      name = "container-instance-delegation"
      service_delegation = {
        name = "Microsoft.ContainerInstance/containerGroups"
        actions = [
          "Microsoft.Network/virtualNetworks/subnets/join/action",
          "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"
        ]
      }
    }
  },
  {
    name             = "subnet-with-nsg"
    address_prefixes = ["10.0.1.0/24"]
    nsgs = [
      # {
      #   name = "nsg0"
      #   resource_group_name = "rg-vnet-module-test"
      # }
      {
        name = "nsg0"
        #resource_group_name = "rg-vnet-module-test"
        rules = [
          {
            name                       = "winrm",
            priority                   = "1001"
            direction                  = "Inbound"
            access                     = "Allow"
            protocol                   = "tcp"
            source_port_range          = "*"
            destination_port_range     = "5985"
            source_address_prefix      = "VirtualNetwork"
            destination_address_prefix = "VirtualNetwork"
          },
          {
            name                       = "web-inbound-http",
            priority                   = "1002"
            direction                  = "Inbound"
            access                     = "Allow"
            protocol                   = "tcp"
            source_port_range          = "*"
            destination_port_range     = "80"
            source_address_prefix      = "*"
            destination_address_prefix = "VirtualNetwork"
          }
        ] 
      },
    ]
  },
  {
    name             = "subnet-with-rt"
    address_prefixes = ["10.0.2.0/24"]
    route_tables = [
      {
        name = "rt0"
        resource_group_name = "rg-vnet-module-test"
      }
    ]
  },
  {
    name             = "subnet-with-service-endpoint"
    address_prefixes = ["10.0.3.0/24"]
    service_endpoints = [ "Microsoft.Storage" ]
  }
]