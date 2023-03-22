
# PoC - Devops - Challenge

Este proyecto contiene infraestructura como codigo, pipelines, Dockerfile, api rest using FastApi Python and manifiestos de kubernetes.

Automatizacion en terraform:

- Creación de un clúster de AKS dentro de una subred privada
- Creación de API Management en modo "Externo"
- Creacion de un contenedor de registro de imagenes (ACR)
- Creacion de Redes y grupo de seguridad de redes
- Creacion de Nginx Ingress controller
- Creacion de Service Principal

Manifiestos de kubernetes:

- Archivo deployment, service e ingress.

Pipeline:
- Build and deploy image in AKS

Python:
Creacion de API usando FastAPI
## Requirements

Terraform v.1.3.1
Helm v3
Python3
Kubelet
## Step by Step

1. Deploy IaC in Azure
Git repository using command:

```
# git clone https://github.com/cvidalch1/challenge-devops.git
# cd challenge-devops/iac-terraform-azure
# az login
# terraform init
# terraform plan
# terraform apply -auto-approve
```

2. Deploy Pipelines
Firts you need create a service connection between docker and aks for deployment. (Note: If you don't have parallelism it's posible install a self-hosted agend on-premise)

After that you can run the Pipelines

3. Publish API in API Management
Using "challenge.openapi.yaml" you can import. To connect http URL ingress
Use the next command to get IP loadbalancer internal.

```
# kubectl get svc -n ingress-controller | grep LoadBalancer | awk '{print $4}'
```
The output show IP private and put in API Management.

4. Test connection
Using postman or curl you can test. Example:
```
curl -X POST \
-H "X-Parse-REST-API-Key: 2f5ae96c-b558-4c7b-a590-a501ae1c3f6c" \
-H "X-JWT-KWY: ${TOKEN}" \
-H "Content-Type: application/json" \
-d '{ "message": "This is a test", "to": "Juan Perez", "from": "Rita Asturia", "timeToLifeSec": 15 }' \
https://${HostnameAPIM}/DevOps
```