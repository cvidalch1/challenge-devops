##############################################################
# Módulo to create a resource-group
##############################################################

resource "azurerm_resource_group" "main" {
  name     = var.name
  location = var.location
  tags     = var.resource_tags
}

