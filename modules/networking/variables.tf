variable "name_prefix" {
  description = "Prefix for all resources"
  type        = string
}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "vnet_address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
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
      address_prefixes = ["10.0.1.0/24"]
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
    main = {
      allocation_method = "Static"
      sku              = "Standard"
    }
  }
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default     = {}
}