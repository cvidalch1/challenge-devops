resource "kubernetes_namespace" "main" {
  metadata {
    labels = {
      mylabel = "label-value"
    }

    name = "ingress-basic"
  }
}

resource "helm_release" "nginx-ingress" {
  name       = "nginx-ingress"
  repository = "https://helm.nginx.com/stable"
  chart      = "nginx-ingress"
  namespace        = "ingress-basic"
  create_namespace = true
  dependency_update          = true 
  #values = [file("${path.module}/templates/template.yaml")]
  set {
    name  = "rbac.create"
    value = "false"
  }

  set {
    name  = "controller.service.loadBalancerIP"
    value = "10.0.1.20"
  }
  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/azure-load-balancer-internal"
    value = "true"
  }
  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/azure-load-balancer-internal-subnet"
    value = "subnet-aks"
  }
}