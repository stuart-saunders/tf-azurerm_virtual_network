locals {

  subnets = { for subnet in var.vnet.subnets :
    "${var.vnet.name}_${subnet.name}" => subnet
  }

}