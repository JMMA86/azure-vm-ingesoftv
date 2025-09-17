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

variable "subnet_ids" {
  description = "Map of subnet names to subnet IDs"
  type        = map(string)
}

variable "public_ip_ids" {
  description = "Map of public IP names to IP IDs"
  type        = map(string)
  default     = {}
}

variable "nsg_ids" {
  description = "Map of NSG names to NSG IDs"
  type        = map(string)
}

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
  default = {}
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default     = {}
}