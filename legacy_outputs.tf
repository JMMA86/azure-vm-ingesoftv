output "public_ip_address" {
  description = "IP pública de la VM creada"
  value       = azurerm_public_ip.main.ip_address
}

output "vm_id" {
  description = "ID de la máquina virtual"
  value       = azurerm_linux_virtual_machine.marin_vm.id
}

output "resource_group_name" {
  description = "Nombre del grupo de recursos"
  value       = azurerm_resource_group.main.name
}

output "ssh_connection" {
  description = "Comando para conectarse por SSH"
  value       = "ssh ${var.admin_username}@${azurerm_public_ip.main.ip_address}"
}

output "login_credentials" {
  description = "Credenciales de acceso a la VM"
  value = {
    username = var.admin_username
    password = var.admin_password
    ip_address = azurerm_public_ip.main.ip_address
  }
  sensitive = true
}
