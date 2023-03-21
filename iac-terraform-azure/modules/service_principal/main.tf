##############################################################
# Module to create an Service Principal and assignment a role
##############################################################

data "azuread_client_config" "current" {}

resource "azuread_application" "main" {
  display_name = var.name
  owners       = [data.azuread_client_config.current.object_id]
}

resource "azuread_service_principal" "main" {
  application_id               = azuread_application.main.application_id
  app_role_assignment_required = false
  owners                       = [data.azuread_client_config.current.object_id]
}

resource "time_rotating" "main" {
  rotation_days = var.rotation_days
}

resource "azuread_service_principal_password" "main" {
  service_principal_id = azuread_service_principal.main.object_id
  rotate_when_changed = {
    rotation = time_rotating.main.id
  }
}

# resource "azurerm_role_assignment" "acrpull_role" {
#   scope                            = azurerm_container_registry.acr.id
#   role_definition_name             = "AcrPull"
#   principal_id                     = azuread_service_principal.example.object_id
#   skip_service_principal_aad_check = true
# }

data "azurerm_subscription" "main" {
}

data "azurerm_client_config" "main" {
}

resource "azurerm_role_assignment" "main" {
  scope                = data.azurerm_subscription.main.id
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.main.object_id
}