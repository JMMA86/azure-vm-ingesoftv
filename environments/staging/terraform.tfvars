# Staging Environment Variables
environment    = "staging"
name_prefix    = "marinvm"
project_name   = "Azure VM Infrastructure"
location       = "Chile Central"
cost_center    = "staging-team"

# Network configuration
vnet_address_space = ["10.1.0.0/16"]

# VM configuration - Staging (balanced cost and performance)
virtual_machines = {
  web = {
    size                            = "Standard_B1s"   # ~$7.59/month
    admin_username                  = "marinadmin"
    admin_password                  = "MarinVM2025@"
    disable_password_authentication = false
    subnet_name                     = "web"
    public_ip_name                  = "web"
    nsg_name                        = "web"
    private_ip_allocation           = "Dynamic"
    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
      disk_size_gb         = 64
    }
    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-focal"
      sku       = "20_04-lts-gen2"
      version   = "latest"
    }
  }
  app = {
    size                            = "Standard_B1s"   # ~$7.59/month
    admin_username                  = "marinadmin"
    admin_password                  = "MarinVM2025@"
    disable_password_authentication = false
    subnet_name                     = "internal"
    public_ip_name                  = "app"
    nsg_name                        = "app"
    private_ip_allocation           = "Dynamic"
    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
      disk_size_gb         = 64
    }
    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-focal"
      sku       = "20_04-lts-gen2"
      version   = "latest"
    }
  }
}