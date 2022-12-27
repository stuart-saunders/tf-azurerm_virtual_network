output "virtual_network_id" {
  description = "The Id of the Virtual Network created"
  value       = azurerm_virtual_network.this.id
}

output "subnets" {
  description = "The details of the subnets created"
  value       = azurerm_subnet.this
}