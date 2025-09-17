# Global Configuration for Azure VM Infrastructure
# This file contains common configurations used across all environments

# Azure Configuration
variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
  default     = "41407763-5cf1-45a1-b9fb-8865e49063e5"
}

variable "allowed_locations" {
  description = "List of allowed Azure regions"
  type        = list(string)
  default     = [
    "Chile Central",
    "Brazil South", 
    "East US",
    "West Europe"
  ]
}

# Common Tags
locals {
  global_tags = {
    ManagedBy     = "Terraform"
    Project       = "Azure VM Infrastructure"
    Owner         = "DevOps Team"
    Repository    = "azure-vm-ingesoftv"
    TerraformPath = path.cwd
  }
}

# Resource Naming Convention
locals {
  naming_convention = {
    resource_group = "{name_prefix}-{environment}-rg"
    virtual_network = "{name_prefix}-{environment}-vnet"
    subnet = "{name_prefix}-{environment}-{subnet_name}-subnet"
    vm = "{name_prefix}-{environment}-{vm_name}-vm"
    nsg = "{name_prefix}-{environment}-{nsg_name}-nsg"
    public_ip = "{name_prefix}-{environment}-{ip_name}-pip"
  }
}

# Cost Management
variable "cost_optimization_enabled" {
  description = "Enable cost optimization features"
  type        = bool
  default     = true
}

variable "auto_shutdown_enabled" {
  description = "Enable auto-shutdown for cost saving"
  type        = bool
  default     = true
}

variable "auto_shutdown_time" {
  description = "Auto-shutdown time (24-hour format)"
  type        = string
  default     = "19:00"
}

# Security Configuration
variable "allowed_ssh_sources" {
  description = "List of allowed source IP ranges for SSH access"
  type        = list(string)
  default     = ["*"]  # Restrict this in production
}

variable "require_secure_transfer" {
  description = "Require secure transfer for storage accounts"
  type        = bool
  default     = true
}

# Backup Configuration
variable "backup_retention_days" {
  description = "Number of days to retain backups"
  type        = number
  default     = 30
}

variable "backup_frequency" {
  description = "Backup frequency"
  type        = string
  default     = "Daily"
  
  validation {
    condition     = contains(["Daily", "Weekly"], var.backup_frequency)
    error_message = "Backup frequency must be either Daily or Weekly."
  }
}