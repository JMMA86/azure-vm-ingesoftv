provider "azurerm" {
  features {}
  subscription_id = "41407763-5cf1-45a1-b9fb-8865e49063e5"
}

# Grupo de recursos
resource "azurerm_resource_group" "main" {
  name     = "${var.name_function}-rg"
  location = var.location
}

# Red virtual
resource "azurerm_virtual_network" "main" {
  name                = "${var.name_function}-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

# Subred
resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
}

# IP pública
resource "azurerm_public_ip" "main" {
  name                = "${var.name_function}-pip"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Grupo de seguridad de red
resource "azurerm_network_security_group" "main" {
  name                = "${var.name_function}-nsg"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  security_rule {
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
}

# Interfaz de red
resource "azurerm_network_interface" "main" {
  name                = "${var.name_function}-nic"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.main.id
  }
}

# Asociar grupo de seguridad con interfaz de red
resource "azurerm_network_interface_security_group_association" "main" {
  network_interface_id      = azurerm_network_interface.main.id
  network_security_group_id = azurerm_network_security_group.main.id
}

# Máquina virtual
resource "azurerm_linux_virtual_machine" "marin_vm" {
  name                = "marinvm"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  size                = "Standard_B1ls"  # VM más económica: ~$3.80/mes
  admin_username      = var.admin_username
  admin_password      = var.admin_password

  disable_password_authentication = false  # Habilitar autenticación por contraseña

  network_interface_ids = [
    azurerm_network_interface.main.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }
}
