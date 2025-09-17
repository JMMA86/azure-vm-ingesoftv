# Compute Module - Virtual Machines and Network Interfaces
resource "azurerm_network_interface" "nic" {
  for_each = var.virtual_machines

  name                = "${var.name_prefix}-${each.key}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_ids[each.value.subnet_name]
    private_ip_address_allocation = each.value.private_ip_allocation
    public_ip_address_id          = lookup(each.value, "public_ip_name", null) != null ? var.public_ip_ids[each.value.public_ip_name] : null
  }

  tags = var.common_tags
}

resource "azurerm_network_interface_security_group_association" "nic_nsg" {
  for_each = var.virtual_machines

  network_interface_id      = azurerm_network_interface.nic[each.key].id
  network_security_group_id = var.nsg_ids[each.value.nsg_name]
}

resource "azurerm_linux_virtual_machine" "vm" {
  for_each = var.virtual_machines

  name                            = "${var.name_prefix}-${each.key}-vm"
  resource_group_name             = var.resource_group_name
  location                        = var.location
  size                            = each.value.size
  admin_username                  = each.value.admin_username
  disable_password_authentication = each.value.disable_password_authentication

  # Conditional password authentication
  admin_password = each.value.disable_password_authentication ? null : each.value.admin_password

  # Conditional SSH key authentication
  dynamic "admin_ssh_key" {
    for_each = each.value.disable_password_authentication ? [1] : []
    content {
      username   = each.value.admin_username
      public_key = each.value.ssh_public_key
    }
  }

  network_interface_ids = [
    azurerm_network_interface.nic[each.key].id,
  ]

  os_disk {
    caching              = each.value.os_disk.caching
    storage_account_type = each.value.os_disk.storage_account_type
    disk_size_gb         = lookup(each.value.os_disk, "disk_size_gb", null)
  }

  source_image_reference {
    publisher = each.value.source_image_reference.publisher
    offer     = each.value.source_image_reference.offer
    sku       = each.value.source_image_reference.sku
    version   = each.value.source_image_reference.version
  }

  tags = var.common_tags
}