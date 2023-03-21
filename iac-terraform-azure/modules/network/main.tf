##############################################################
# Network module to create a vnet and subnet. 
# Also a network security group with some rules.
##############################################################


data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}

resource "azurerm_virtual_network" "main" {
  name                = var.name
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location
  address_space       = [var.address_space]
  dns_servers         = var.dns_servers
  tags                = var.resource_tags
}

resource "azurerm_subnet" "main" {
  name                 = var.subnet_names[count.index]
  virtual_network_name = azurerm_virtual_network.main.name
  resource_group_name  = data.azurerm_resource_group.main.name
  address_prefixes     = [var.subnet_prefixes[count.index]]
  count                = length(var.subnet_names)
}

resource "azurerm_network_security_group" "main" {
  name                = var.name_nsg
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
}


resource "azurerm_network_security_rule" "Port-80" {
  name                        = "Port-80"
  priority                    = 101
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = data.azurerm_resource_group.main.name
  network_security_group_name = azurerm_network_security_group.main.name
}


resource "azurerm_network_security_rule" "Port-443" {
  name                        = "Port-443"
  priority                    = 102
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = data.azurerm_resource_group.main.name
  network_security_group_name = azurerm_network_security_group.main.name
}

resource "azurerm_network_security_rule" "Port-3443" {
  name                        = "Port-3443"
  priority                    = 103
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3443"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = data.azurerm_resource_group.main.name
  network_security_group_name = azurerm_network_security_group.main.name
}

resource "azurerm_subnet_network_security_group_association" "main" {
  subnet_id                 = azurerm_subnet.main[1].id
  network_security_group_id = azurerm_network_security_group.main.id
}