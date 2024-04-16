output "resource_group_name" {
  value = azurerm_resource_group.network.name
}

output "virtual_network_name" {
  value = azurerm_virtual_network.main.name
}

output "prod_subnet_id" {
  value = azurerm_subnet.prod.id
}

output "test_subnet_id" {
  value = azurerm_subnet.test.id
}

output "dev_subnet_id" {
  value = azurerm_subnet.dev.id
}

output "admin_subnet_id" {
  value = azurerm_subnet.admin.id
}
