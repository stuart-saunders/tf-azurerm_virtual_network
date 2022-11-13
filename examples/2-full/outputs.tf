output "virtual_network_id" {
  value = module.vnet.virtual_network_id
}

output "subnets" {
  value = [for v in module.vnet.subnets :
    {
      id   = v.id
      name = v.name
    }
  ]
}