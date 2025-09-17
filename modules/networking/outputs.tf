output "vnet_id" {
  description = "ID of the virtual network"
  value       = azurerm_virtual_network.vnet.id
}

output "vnet_name" {
  description = "Name of the virtual network"
  value       = azurerm_virtual_network.vnet.name
}

output "subnet_ids" {
  description = "Map of subnet names to subnet IDs"
  value       = { for k, v in azurerm_subnet.subnet : k => v.id }
}

output "public_ip_addresses" {
  description = "Map of public IP names to IP addresses"
  value       = { for k, v in azurerm_public_ip.pip : k => v.ip_address }
}

output "public_ip_ids" {
  description = "Map of public IP names to IP IDs"
  value       = { for k, v in azurerm_public_ip.pip : k => v.id }
}