output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.alex-watchlist-rg.name
}

output "azurerm_linux_web_application_name" {
  description = "Name of the Linux web application"
  value       = azurerm_linux_web_app.alex-watchlist-web-app.name
}
