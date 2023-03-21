##############################################################
# Módulo network, para crear una vnet.
##############################################################

output "id" {
  description = "ID de la vnet"
  value       = azurerm_virtual_network.main.id
}

output "name" {
  description = "Nombre de la vnet"
  value       = azurerm_virtual_network.main.name
}

output "address_space" {
  description = "El espacio a utilizar dentro de la vnet."
  value       = azurerm_virtual_network.main.address_space
}

output "subnets" {
  description = "Id de la subnet dentro de la vnet."
  value       = azurerm_subnet.main.*.id
}