##############################################################
# Module to create an AKS cluster 
##############################################################

data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}

resource "azurerm_kubernetes_cluster" "main" {
  name                = var.name
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location

  tags = var.resource_tags

  dns_prefix         = var.dns_prefix
  kubernetes_version = var.kubernetes_version

  default_node_pool {
    name            = "default"
    node_count      = var.agent_vm_count
    vm_size         = var.agent_vm_size
    os_disk_size_gb = 30
    vnet_subnet_id  = var.vnet_subnet_id
  }

  network_profile {
    network_plugin     = var.network_plugin
    network_policy     = var.network_policy
    service_cidr       = var.service_cidr
    dns_service_ip     = var.dns_ip
    docker_bridge_cidr = var.docker_cidr
  }

  service_principal {
    client_id     = var.service_principal_id
    client_secret = var.service_principal_secret
  }
}
