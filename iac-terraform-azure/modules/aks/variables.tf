##############################################################
# Módulo de creación de AKS
##############################################################

variable "name" {
  description = "Nombre del cluster de kubernetes."
  type        = string
}

variable "resource_group_name" {
  description = "Nombre del grupo de recursos."
  type        = string
}

variable "resource_tags" {
  description = "Map de tags"
  type        = map(string)
  default     = {}
}

variable "dns_prefix" {
  type = string
}

variable "service_principal_id" {
  type = string
}

variable "service_principal_secret" {
  type = string
}

variable "agent_vm_count" {
  type    = string
  default = "2"
}

variable "agent_vm_size" {
  type    = string
  default = "Standard_D2s_v3"
}

variable "kubernetes_version" {
  type    = string
  default = "1.18.10"
}

variable "output_directory" {
  type    = string
  default = "./output"
}

variable "vnet_subnet_id" {
  type = string
}

# variable "enable_virtual_node_addon" {
#   type    = string
#   default = "false"
# }

variable "kubeconfig_to_disk" {
  description = "Flag para guardar el kubeconfig en el disco"
  type        = string
  default     = "true"
}

variable "kubeconfig_filename" {
  description = "Nombre del kubeconfig."
  type        = string
  default     = "bedrock_kube_config"
}

variable "service_cidr" {
  default     = "10.0.0.0/16"
  description = "Usado para asignar las IP internas dentro del cluster de kubernetes (verificar que estas IP no sean utilizadas en ninguna otra parte de la red, por ejemplo, VPN o express Route)."
  type        = string
}

variable "dns_ip" {
  default     = "10.0.0.10"
  description = "Tiene que ser la ip .10 del rango de ips"
  type        = string
}

variable "docker_cidr" {
  default     = "172.17.0.1/16"
  description = "IP utilizadas dentro de los nodos de docker. Default 172.17.0.1/16."
}

variable "network_plugin" {
  default     = "azure"
  description = "Plugin utilizado para la red de kubernetes, azure o kubenet. Default azure"
}

variable "network_policy" {
  default     = "azure"
  description = "Policy a utilizar para la red de kubernetes, azure o calico. Default azure"
}

# variable "oms_agent_enabled" {
#   default     = "false"
#   description = "Activa el agente de OMS para el monitoreo del AKS"
#   type        = string
# }