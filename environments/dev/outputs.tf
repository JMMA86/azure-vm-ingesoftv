output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.main.name
}

output "resource_group_id" {
  description = "ID of the resource group"
  value       = azurerm_resource_group.main.id
}

output "virtual_network_id" {
  description = "ID of the virtual network"
  value       = module.networking.vnet_id
}

output "public_ip_addresses" {
  description = "Map of public IP addresses"
  value       = module.networking.public_ip_addresses
}

output "vm_ids" {
  description = "Map of VM IDs"
  value       = module.compute.vm_ids
}

output "vm_private_ips" {
  description = "Map of VM private IP addresses"
  value       = module.compute.vm_private_ips
}

output "ssh_connection_commands" {
  description = "SSH connection commands for each VM"
  value = {
    for vm_name, vm_config in var.virtual_machines :
    vm_name => vm_config.public_ip_name != null ? 
      "ssh ${vm_config.admin_username}@${module.networking.public_ip_addresses[vm_config.public_ip_name]}" : 
      "No public IP assigned"
  }
}

output "environment_info" {
  description = "Environment information"
  value = {
    environment = var.environment
    location    = var.location
    cost_center = var.cost_center
    project     = var.project_name
  }
}