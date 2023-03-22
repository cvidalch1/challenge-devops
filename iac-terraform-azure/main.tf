terraform {
  required_version = ">=1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
}


provider "azurerm" {
  features {}
}


provider "kubernetes" {
  host                   = module.aks.host
  username               = module.aks.username
  password               = module.aks.password
  client_certificate     = base64decode(module.aks.client_certificate)
  client_key             = base64decode(module.aks.client_key)
  cluster_ca_certificate = base64decode(module.aks.cluster_ca_certificate)

}

provider "helm" {
  kubernetes {
      host                   = module.aks.host
      username               = module.aks.username
      password               = module.aks.password
      client_certificate     = base64decode(module.aks.client_certificate)
      client_key             = base64decode(module.aks.client_key)
      cluster_ca_certificate = base64decode(module.aks.cluster_ca_certificate)
  }
}

module "service_principal" {
    source                              =  "./modules/service_principal"
    role_definition_name                =  "Contributor"
    rotation_days                       =  365
    name                                =  "sp-devops-1"

}

module "resource_group" {
    source                              =  "./modules/resource_group"
    #environment                         = "challenge"
    location                            =  "eastus"
    name                                =  "rg-devops"

}

module "network" {
    source                              =  "./modules/network"
    depends_on                          =  [module.resource_group]
    resource_group_name                 =  module.resource_group.name
    name                                =  "vn-devops"
    name_nsg                            =  "nsg-devops"
    address_space                       =  "10.0.0.0/16"
    subnet_prefixes                     =  ["10.0.1.0/24","10.0.2.0/24"]
    subnet_names                        =  ["subnet-aks","subnet-apim"]
}

module "acr" {
    source                              =  "./modules/acr"
    depends_on                          =  [module.resource_group]
    resource_group_name                 =  module.resource_group.name
    name                                =  "acrdevopschall"
    sku                                 =  "Standard"
}

module "aks" {
    source                              =  "./modules/aks"
    depends_on                          =  [module.network]
    resource_group_name                 =  module.resource_group.name
    name                                =  "aks-devops"
    dns_prefix                          =  "devops"
    kubernetes_version                  =  "1.24.9"
    agent_vm_count                      =  "2"
    agent_vm_size                       =  "Standard_D2_v2"
    service_principal_id                =  module.service_principal.client_id
    service_principal_secret            =  module.service_principal.client_secret
    vnet_subnet_id                      =  module.network.subnets[0]
    network_plugin                      =  "azure"
    network_policy                      =  "azure"
    service_cidr                        =  "10.10.0.0/16"
    dns_ip                              =  "10.10.0.10"
    docker_cidr                         =  "172.17.0.1/16"
}

module "helm" {
    source                              =  "./modules/helm"
    depends_on                          =  [module.aks]
}

module "apim" {
    source                              =  "./modules/apim"
    depends_on                          =  [module.network]
    resource_group_name                 =  module.resource_group.name
    apim_name                           =  "apim-devops-15"
    apim_publisher_name                 =  "devops"
    apim_publisher_email                =  "christian.vidalch@gmail.com" 
    sku_name                            =  "Developer_1" 
    virtual_network_type                =  "External"
    name_puip                           =  "puip-devops"
    domain_name_label                   =  "devops-challenge"
    subnet_id                           =  module.network.subnets[1]
}


