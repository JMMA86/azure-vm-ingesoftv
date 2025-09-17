output "nsg_ids" {
  description = "Map of NSG names to NSG IDs"
  value       = { for k, v in azurerm_network_security_group.nsg : k => v.id }
}

output "nsg_names" {
  description = "Map of NSG names"
  value       = { for k, v in azurerm_network_security_group.nsg : k => v.name }
}