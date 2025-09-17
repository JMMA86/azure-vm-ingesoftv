# Module Versions and Sources
# This file manages module versions for consistency across environments

locals {
  module_versions = {
    networking = "1.0.0"
    compute    = "1.0.0"  
    security   = "1.0.0"
  }
}

# Module Sources (for future remote modules)
locals {
  module_sources = {
    networking_remote = "git::https://github.com/your-org/terraform-azure-networking.git?ref=v1.0.0"
    compute_remote    = "git::https://github.com/your-org/terraform-azure-compute.git?ref=v1.0.0"
    security_remote   = "git::https://github.com/your-org/terraform-azure-security.git?ref=v1.0.0"
  }
}

# Environment-specific module configurations
locals {
  environment_configs = {
    dev = {
      vm_auto_shutdown    = true
      backup_enabled      = false
      monitoring_enabled  = false
      high_availability   = false
      cost_optimization   = true
    }
    staging = {
      vm_auto_shutdown    = true
      backup_enabled      = true
      monitoring_enabled  = true
      high_availability   = false
      cost_optimization   = true
    }
    prod = {
      vm_auto_shutdown    = false
      backup_enabled      = true
      monitoring_enabled  = true
      high_availability   = true
      cost_optimization   = false
    }
  }
}

# VM Size recommendations by environment
locals {
  recommended_vm_sizes = {
    dev = {
      small  = "Standard_B1ls"  # $3.80/month
      medium = "Standard_B1s"   # $7.59/month
      large  = "Standard_B2s"   # $30.37/month
    }
    staging = {
      small  = "Standard_B1s"   # $7.59/month
      medium = "Standard_B2s"   # $30.37/month
      large  = "Standard_B4ms"  # $121.47/month
    }
    prod = {
      small  = "Standard_B2s"   # $30.37/month
      medium = "Standard_B4ms"  # $121.47/month
      large  = "Standard_B8ms"  # $242.93/month
    }
  }
}

# Storage type recommendations
locals {
  recommended_storage = {
    dev = {
      os_disk = "Standard_LRS"
      data_disk = "Standard_LRS"
    }
    staging = {
      os_disk = "Standard_LRS"
      data_disk = "Standard_LRS"
    }
    prod = {
      os_disk = "Premium_LRS"
      data_disk = "Premium_LRS"
    }
  }
}