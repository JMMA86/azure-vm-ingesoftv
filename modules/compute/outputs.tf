output "vm_ids" {
  description = "Map of VM names to VM IDs"
  value       = { for k, v in azurerm_linux_virtual_machine.vm : k => v.id }
}

output "vm_names" {
  description = "Map of VM names"
  value       = { for k, v in azurerm_linux_virtual_machine.vm : k => v.name }
}

output "vm_private_ips" {
  description = "Map of VM names to private IP addresses"
  value       = { for k, v in azurerm_network_interface.nic : k => v.private_ip_address }
}

output "nic_ids" {
  description = "Map of VM names to NIC IDs"
  value       = { for k, v in azurerm_network_interface.nic : k => v.id }
}