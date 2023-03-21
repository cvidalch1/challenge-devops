variable "resource_group_name" {
  description = "Nombre del grupo de recursos."
  type        = string
}

variable "name" {
  description = "Name of the Azure Container Registry"
  type        = string
}

variable "sku" {
  description = "Sku for Azure Container Registry"
  type        = string
}