# Production Environment Variables
environment    = "prod"
name_prefix    = "marinvm"
project_name   = "Azure VM Infrastructure"
location       = "Chile Central"
cost_center    = "prod-team"

# Network configuration
vnet_address_space = ["10.2.0.0/16"]

# VM configuration - Production (high performance and reliability)
virtual_machines = {
  web = {
    size                            = "Standard_B2s"   # ~$30.37/month
    admin_username                  = "marinadmin"
    admin_password                  = "MarinVM2025@"
    disable_password_authentication = false
    subnet_name                     = "web"
    public_ip_name                  = "web"
    nsg_name                        = "web"
    private_ip_allocation           = "Dynamic"
    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Premium_LRS"
      disk_size_gb         = 128
    }
    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-focal"
      sku       = "20_04-lts-gen2"
      version   = "latest"
    }
  }
  app = {
    size                            = "Standard_B2s"   # ~$30.37/month
    admin_username                  = "marinadmin"
    admin_password                  = "MarinVM2025@"
    disable_password_authentication = false
    subnet_name                     = "app"
    nsg_name                        = "app"
    private_ip_allocation           = "Dynamic"
    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Premium_LRS"
      disk_size_gb         = 128
    }
    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-focal"
      sku       = "20_04-lts-gen2"
      version   = "latest"
    }
  }
  db = {
    size                            = "Standard_B1s"   # ~$7.59/month
    admin_username                  = "marinadmin"
    admin_password                  = "MarinVM2025@"
    disable_password_authentication = false
    subnet_name                     = "db"
    nsg_name                        = "db"
    private_ip_allocation           = "Dynamic"
    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Premium_LRS"
      disk_size_gb         = 256
    }
    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-focal"
      sku       = "20_04-lts-gen2"
      version   = "latest"
    }
  }
  bastion = {
    size                            = "Standard_B1ls"  # ~$3.80/month
    admin_username                  = "marinadmin"
    admin_password                  = "MarinVM2025@"
    disable_password_authentication = false
    subnet_name                     = "management"
    public_ip_name                  = "bastion"
    nsg_name                        = "bastion"
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