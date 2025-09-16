variable "name_function" {
  type        = string
  description = "Nombre base para todos los recursos"
  default     = "marinvm"
}

variable "location" {
  type        = string
  default     = "Chile Central"
  description = "Región de Azure donde se desplegará la VM"
}

variable "admin_username" {
  type        = string
  default     = "marinadmin"
  description = "Nombre de usuario administrador para la VM"
}

variable "admin_password" {
  type        = string
  default     = "MarinVM2024!"
  description = "Contraseña para el usuario administrador"
  sensitive   = true
}