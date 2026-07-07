# Jenkins CI/CD Pipeline Flow

```mermaid
flowchart TD

Developer --> Git[Git Repository]

Git --> Jenkins[Jenkins Controller]

Jenkins --> Agent[Jenkins Agent]

Agent --> Checkout[Checkout Code]

Checkout --> Test[Validate and Unit Test]

Test --> Build[Build Application]

Build --> Docker[Build Docker Image]

Docker --> Scan[Security Scan]

Scan --> Nexus[Nexus Container Registry]

Nexus --> Helm[Helm Deployment]

Helm --> K8s[Kubernetes Lab Environment]

K8s --> Smoke[Smoke Test]

Smoke --> Approval{Manual Approval}

Approval -->|Approved| Demo[Kubernetes Demo Environment]

Approval -->|Rejected| Rollback[Rollback]

K8s --> Ingress[NGINX Ingress]

Ingress --> DNS[Internal DNS]

DNS --> Users[Lab/Demo Users]
