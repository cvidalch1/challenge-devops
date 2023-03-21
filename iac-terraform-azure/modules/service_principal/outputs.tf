##############################################################
# Modulo service-principal
##############################################################


output "id" {
  description = "Azure AD Service Principal ID"
  value       = azuread_service_principal.main.object_id
}

output "client_id" {
  description = "Application ID in Azure AD"
  value       = azuread_service_principal.main.application_id
}

output "name" {
  description = "Application name for the main service in Azure AD"
  value       = azuread_service_principal.main.display_name
}

output "client_secret" {
  description = "Password generated for the main service"
  value       = azuread_service_principal_password.main.value
  sensitive   = true
}
