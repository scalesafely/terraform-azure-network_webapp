output "data_subnet_id" {
  value = azurerm_subnet.data_subnet.id
}

output "web_subnet_id" {
  value = azurerm_subnet.web_subnet.id
}
