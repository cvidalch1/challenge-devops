resource "kubernetes_namespace" "main" {
  metadata {
    labels = {
      mylabel = "label-value"
    }

    name = "ingress-basic"
  }
}

resource "kubernetes_namespace" "app" {
  metadata {
    labels = {
      mylabel = "label-value"
    }

    name = "challenge-devops"
  }
}


resource "helm_release" "nginx-ingress" {
  name       = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace        = "ingress-basic"
  create_namespace = true
  dependency_update          = true 
  values = [file("${path.module}/templates/template.yaml")]
  }