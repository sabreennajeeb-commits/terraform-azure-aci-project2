output "resource_group_name" {
  description = "The name of the created Azure Resource Group"
  value       = azurerm_resource_group.project_rg.name
}

output "container_group_name" {
  description = "The name of the Azure Container Instance"
  value       = azurerm_container_group.web_app.name
}

output "container_ip_address" {
  description = "The public IP address of the Azure Container Instance"
  value       = azurerm_container_group.web_app.ip_address
}

output "container_fqdn" {
  description = "The public DNS name of the Azure Container Instance"
  value       = azurerm_container_group.web_app.fqdn
}