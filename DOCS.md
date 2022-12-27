## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.30 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.35.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_network_security_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_rule.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_route.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route) | resource |
| [azurerm_route_table.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route_table) | resource |
| [azurerm_subnet.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_network_security_group_association.external_nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_network_security_group_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_route_table_association.external_rt](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_route_table_association) | resource |
| [azurerm_subnet_route_table_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_route_table_association) | resource |
| [azurerm_virtual_network.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [azurerm_virtual_network_dns_servers.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_dns_servers) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_space"></a> [address\_space](#input\_address\_space) | The address space(s) used by the Virtual Network | `list(string)` | n/a | yes |
| <a name="input_ddos_protection_plan"></a> [ddos\_protection\_plan](#input\_ddos\_protection\_plan) | (Optional) Enables a DDoS Protection Plan on the Virtual Network | <pre>object({<br>    enable = bool<br>    id     = string<br>  })</pre> | <pre>{<br>  "enable": false,<br>  "id": null<br>}</pre> | no |
| <a name="input_dns_servers"></a> [dns\_servers](#input\_dns\_servers) | (Optional) List of IP addresses of DNS servers | `list(string)` | `[]` | no |
| <a name="input_edge_zone"></a> [edge\_zone](#input\_edge\_zone) | (Optional) The Edge Zone within the Azure Region where this Virtual Network should exist | `string` | `null` | no |
| <a name="input_flow_timeout_in_minutes"></a> [flow\_timeout\_in\_minutes](#input\_flow\_timeout\_in\_minutes) | (Optional) The flow timeout in minutes for the Virtual Network, which is used to enable connection tracking for intra-VM flows. Possible values are between 4 and 30 minutes. | `number` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | The location in which to create the Virtual Network | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the Virtual Network to create | `string` | n/a | yes |
| <a name="input_resource_group_location"></a> [resource\_group\_location](#input\_resource\_group\_location) | (Required) The Azure region in which the Resource Group should be created | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name the Resource Group in which to create the Virtual Network | `string` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | The definitions of the Subnets that the Virtual Network should contain | <pre>list(object({<br>    name             = string<br>    address_prefixes = list(string)<br><br>    delegation = optional(object({<br>      name = optional(string, null)<br>      service_delegation = optional(object({<br>        name    = optional(string, null)<br>        actions = optional(list(string), null)<br>      }), null)<br>    }), null)<br><br>    private_endpoint_network_policies_enabled     = optional(bool, true)<br>    private_link_service_network_policies_enabled = optional(bool, true)<br><br>    service_endpoints           = optional(list(string), null)<br>    service_endpoint_policy_ids = optional(list(string), null)<br><br>    nsgs = optional(list(object({<br>      name = string<br>      rules = optional(list(object({<br>        name                       = string<br>        priority                   = string<br>        direction                  = string<br>        access                     = string<br>        protocol                   = string<br>        source_port_range          = string<br>        destination_port_range     = string<br>        source_address_prefix      = string<br>        destination_address_prefix = string<br>      })), null)<br>    })), [])<br><br>    nsg_ids = optional(list(string), [])<br><br>    route_tables = optional(list(object({<br>      name                          = string<br>      disable_bgp_route_propagation = optional(bool, false)<br><br>      routes = optional(list(object({<br>        name           = string<br>        address_prefix = optional(string)<br>        next_hop_type  = optional(string)<br>      })), [])<br>    })), [])<br><br>    route_table_ids = optional(list(string), [])<br><br>  }))</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) The list of tags to apply to the resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_subnets"></a> [subnets](#output\_subnets) | The details of the subnets created |
| <a name="output_virtual_network_id"></a> [virtual\_network\_id](#output\_virtual\_network\_id) | The Id of the Virtual Network created |
