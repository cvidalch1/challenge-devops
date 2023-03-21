variable "name" {
  description = "Name for the service principal"
  type        = string
}

variable "rotation_days" {
  description = "The rotation days for service principal password"
  type        = number
}

variable "role_definition_name" {
  description = "Role defined for the Service Principal"
  type        = string
}