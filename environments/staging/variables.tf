# Common Variables
variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
  default     = "41407763-5cf1-45a1-b9fb-8865e49063e5"
}

variable "name_prefix" {
  description = "Prefix for all resources"
  type        = string
  default     = "marinvm"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "Azure VM Infrastructure"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "staging"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "Chile Central"
}

variable "cost_center" {
  description = "Cost center for billing"
  type        = string
  default     = "staging-team"
}

# Staging-specific configurations (cost-balanced)
variable "vnet_address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
  default     = ["10.1.0.0/16"]
}

variable "subnets" {
  description = "Map of subnets to create"
  type = map(object({
    address_prefixes = list(string)
    delegation = optional(object({
      name = string
      service_delegation = object({
        name    = string
        actions = list(string)
      })
    }))
  }))
  default = {
    internal = {
      address_prefixes = ["10.1.1.0/24"]
    }
    web = {
      address_prefixes = ["10.1.2.0/24"]
    }
    db = {
      address_prefixes = ["10.1.3.0/24"]
    }
  }
}

variable "public_ips" {
  description = "Map of public IPs to create"
  type = map(object({
    allocation_method = string
    sku              = string
  }))
  default = {
    web = {
      allocation_method = "Static"
      sku              = "Standard"
    }
    app = {
      allocation_method = "Static"
      sku              = "Standard"
    }
  }
}

variable "network_security_groups" {
  description = "Network security groups configuration"
  type = map(object({
    security_rules = map(object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string
    }))
  }))
  default = {
    web = {
      security_rules = {
        SSH = {
          name                       = "SSH"
          priority                   = 1001
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "22"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        }
        HTTP = {
          name                       = "HTTP"
          priority                   = 1002
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "80"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        }
        HTTPS = {
          name                       = "HTTPS"
          priority                   = 1003
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "443"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        }
      }
    }
    app = {
      security_rules = {
        SSH = {
          name                       = "SSH"
          priority                   = 1001
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "22"
          source_address_prefix      = "10.1.0.0/16"
          destination_address_prefix = "*"
        }
        API = {
          name                       = "API"
          priority                   = 1002
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "8080"
          source_address_prefix      = "10.1.0.0/16"
          destination_address_prefix = "*"
        }
      }
    }
  }
}

# Staging VMs - Better specs for testing
variable "virtual_machines" {
  description = "Map of virtual machines to create"
  type = map(object({
    size                            = string
    admin_username                  = string
    admin_password                  = optional(string)
    disable_password_authentication = bool
    ssh_public_key                  = optional(string)
    subnet_name                     = string
    public_ip_name                  = optional(string)
    nsg_name                        = string
    private_ip_allocation           = string
    os_disk = object({
      caching              = string
      storage_account_type = string
      disk_size_gb         = optional(number)
    })
    source_image_reference = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })
  }))
  default = {
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
}