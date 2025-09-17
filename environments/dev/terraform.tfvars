# Development Environment Variables
environment    = "dev"
name_prefix    = "marinvm"
project_name   = "Azure VM Infrastructure"
location       = "Chile Central"
cost_center    = "dev-team"

# Network configuration
vnet_address_space = ["10.0.0.0/16"]

# VM configuration - Development (cost-optimized)
virtual_machines = {
  main = {
    size                            = "Standard_B1ls"  # ~$3.80/month
    admin_username                  = "marinadmin"
    admin_password                  = "MarinVM2025@"
    disable_password_authentication = false
    subnet_name                     = "internal"
    public_ip_name                  = "main"
    nsg_name                        = "main"
    private_ip_allocation           = "Dynamic"
    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
      disk_size_gb         = 30
    }
    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-focal"
      sku       = "20_04-lts-gen2"
      version   = "latest"
    }
  }
}