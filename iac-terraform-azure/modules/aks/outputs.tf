##############################################################
# Módulo de creación de AKS
##############################################################
output "id" {
  value = azurerm_kubernetes_cluster.main.id
}

output "client_certificate" {
  sensitive = true
  value     = azurerm_kubernetes_cluster.main.kube_config.0.client_certificate
}

output "client_key" {
  sensitive = true
  value     = azurerm_kubernetes_cluster.main.kube_config.0.client_key

}
output "cluster_ca_certificate" {
  sensitive = true
  value     = azurerm_kubernetes_cluster.main.kube_config.0.cluster_ca_certificate
}

output "host" {
  sensitive = true
  value     = azurerm_kubernetes_cluster.main.kube_config.0.host
}

output "username" {
  sensitive = true
  value     = azurerm_kubernetes_cluster.main.kube_config.0.username
}

output "password" {
  sensitive = true
  value     = azurerm_kubernetes_cluster.main.kube_config.0.password
}



output "kube_config" {
  sensitive = true
  value     = azurerm_kubernetes_cluster.main.kube_config_raw
}

# output "kubeconfig_done" {
#   value = join("", local_file.cluster_credentials.*.id)
# }

output "kube_admin_config"{
  sensitive = true
  value = azurerm_kubernetes_cluster.main.kube_config
}