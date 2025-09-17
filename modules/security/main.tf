# Security Module - Network Security Groups and Rules
resource "azurerm_network_security_group" "nsg" {
  for_each = var.network_security_groups

  name                = "${var.name_prefix}-${each.key}-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = var.common_tags
}

resource "azurerm_network_security_rule" "rules" {
  for_each = { for rule in local.security_rules : rule.key => rule }

  name                        = each.value.name
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg[each.value.nsg_key].name
}

locals {
  security_rules = flatten([
    for nsg_key, nsg in var.network_security_groups : [
      for rule_key, rule in nsg.security_rules : {
        key                        = "${nsg_key}-${rule_key}"
        nsg_key                    = nsg_key
        name                       = rule.name
        priority                   = rule.priority
        direction                  = rule.direction
        access                     = rule.access
        protocol                   = rule.protocol
        source_port_range          = rule.source_port_range
        destination_port_range     = rule.destination_port_range
        source_address_prefix      = rule.source_address_prefix
        destination_address_prefix = rule.destination_address_prefix
      }
    ]
  ])
}