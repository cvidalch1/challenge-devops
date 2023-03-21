##############################################################
# Módulo network, para crear una vnet.
##############################################################

variable "name" {
  description = "Name of the Virtual Network"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "resource_tags" {
  description = "Map de tags"
  type        = map(string)
  default     = {}
}

variable "address_space" {
  description = "Network space to use"
  default     = "10.0.0.0/16"
}

# If no DNS is placed, Azure DNS is used by default
variable "dns_servers" {
  description = "DNS servers to use within the vnet"
  default     = []
}

variable "subnet_prefixes" {
  description = "Subnet Prefix"
  default     = ["10.0.1.0/24"]
}

variable "subnet_names" {
  description = "List of subnets within the vnet"
  default     = ["subnet1"]
}

variable "name_nsg" {
  description = "Name of the Network Security Group"
  type        = string
}