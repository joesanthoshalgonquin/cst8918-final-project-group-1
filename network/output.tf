output "resource_group_name" {
  value = azurerm_resource_group.network.name
}

output "virtual_network_name" {
  value = azurerm_virtual_network.main.name
}

output "subnet_ids" {
  value = [for _, subnet in azurerm_subnet.subnets : subnet.id]
}
