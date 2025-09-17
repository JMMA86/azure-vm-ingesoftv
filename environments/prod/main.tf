# Production Environment Configuration
terraform {
  required_version = ">= 1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

# Resource Group
resource "azurerm_resource_group" "main" {
  name     = "${var.name_prefix}-${var.environment}-rg"
  location = var.location

  tags = local.common_tags
}

# Networking Module
module "networking" {
  source = "../../modules/networking"

  name_prefix         = "${var.name_prefix}-${var.environment}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  vnet_address_space  = var.vnet_address_space
  subnets             = var.subnets
  public_ips          = var.public_ips
  common_tags         = local.common_tags
}

# Security Module
module "security" {
  source = "../../modules/security"

  name_prefix              = "${var.name_prefix}-${var.environment}"
  location                 = azurerm_resource_group.main.location
  resource_group_name      = azurerm_resource_group.main.name
  network_security_groups  = var.network_security_groups
  common_tags              = local.common_tags
}

# Compute Module
module "compute" {
  source = "../../modules/compute"

  name_prefix         = "${var.name_prefix}-${var.environment}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  subnet_ids          = module.networking.subnet_ids
  public_ip_ids       = module.networking.public_ip_ids
  nsg_ids             = module.security.nsg_ids
  virtual_machines    = var.virtual_machines
  common_tags         = local.common_tags
}

locals {
  common_tags = {
    Environment   = var.environment
    Project       = var.project_name
    ManagedBy     = "Terraform"
    CostCenter    = var.cost_center
    CreatedDate   = formatdate("YYYY-MM-DD", timestamp())
    CriticalLevel = "High"
    Backup        = "Daily"
  }
}