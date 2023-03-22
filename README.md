
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

- Archivo deployment, autoscaling automatic, service e ingress.

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
First you need to create a service connection to docker and aks for the deployment. (Note: if you don't have parallelism, it is possible to install a self-hosted agent on-premises).
Modify pipeline if you don't use parallelism.

Replace Line 31 and 32 and uncomment line 20

```
    pool:
      vmImage: $(vmImageName)
```

Then you are ready to run Pipelines

3. Publish API in API Management
Using "challenge.openapi.yaml" you can import it. To use the ingress as a backend use the following command to get the internal IP load balancer:

```
# kubectl get svc -n ingress-controller | grep LoadBalancer | awk '{print $4}'
```
The output shows the private IP and is placed in API Management.

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