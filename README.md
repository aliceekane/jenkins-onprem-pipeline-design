# Jenkins On-Prem CI/CD Pipeline Architecture

## Overview

This repository demonstrates the design of a Jenkins-based CI/CD pipeline architecture for an on-premises Lab and Demo environment.

The solution supports building, testing, scanning, publishing, and deploying containerized applications using enterprise platform engineering practices.

The design focuses on:

* Automated CI/CD workflows
* Secure container delivery
* Kubernetes-based deployments
* Artifact management
* Repeatable deployments
* Operational support and rollback strategies

This project was created as part of the Platform Engineer II technical challenge.

---

# Architecture Overview

The CI/CD workflow follows this process:

```
Developer
    |
    v
Git Repository
    |
    v
Jenkins Controller
    |
    v
Jenkins Agent
    |
    +--> Validate
    |
    +--> Unit Test
    |
    +--> Build Application
    |
    +--> Build Docker Image
    |
    +--> Security Scan (Trivy)
    |
    v
Nexus Container Registry
    |
    v
Helm Deployment
    |
    v
Kubernetes Lab Environment
    |
    v
Smoke Test
    |
    v
Manual Approval
    |
    v
Kubernetes Demo Environment
```

A detailed architecture diagram is available here:

```
docs/diagrams/pipeline-flow.md
```

---

# Technology Stack

## CI/CD

* Jenkins
* Jenkins Pipeline
* Jenkins Agents

## Containerization

* Docker
* Container image tagging using Jenkins build numbers

## Artifact Management

* Nexus Repository

## Deployment

* Kubernetes
* Helm

## Networking

* NGINX Ingress Controller
* Internal DNS
* TLS Certificates

## Security

* Trivy container image scanning
* Jenkins Credentials
* Kubernetes RBAC
* Kubernetes Secrets

---

# Repository Structure

```
jenkins-onprem-pipeline-design/

├── README.md
├── Jenkinsfile
│
├── docs/
│   ├── architecture.md
│   ├── security.md
│   ├── runbook.md
│   ├── assumptions-and-tradeoffs.md
│   └── diagrams/
│       └── pipeline-flow.md
│
├── deploy/
│   └── helm/
│       ├── Chart.yaml
│       ├── values-lab.yaml
│       ├── values-demo.yaml
│       └── templates/
│           ├── deployment.yaml
│           ├── service.yaml
│           ├── ingress.yaml
│           └── configmap.yaml
│
├── scripts/
│
└── examples/
    └── app/
        ├── app.py
        ├── Dockerfile
        ├── requirements.txt
        └── README.md
```

---

# CI/CD Pipeline Stages

The Jenkins pipeline includes the following stages:

## 1. Source Checkout

Jenkins retrieves application source code from the Git repository.

---

## 2. Validation and Testing

The pipeline validates the application and executes unit tests before packaging.

---

## 3. Docker Image Build

The application is packaged into a Docker container image.

Example:

```
demo-app:15
```

Images use immutable build-based tags instead of the `latest` tag to improve traceability and rollback capability.

---

## 4. Security Scanning

Container images are scanned using Trivy.

The pipeline prevents vulnerable images from being published when critical security issues are detected.

---

## 5. Artifact Publishing

Approved container images are pushed to the internal Nexus repository.

---

## 6. Kubernetes Deployment

The application is deployed using Helm charts.

Lab deployment:

```
helm upgrade --install demo-app deploy/helm \
-f deploy/helm/values-lab.yaml
```

Demo deployment:

```
helm upgrade --install demo-app deploy/helm \
-f deploy/helm/values-demo.yaml
```

---

## 7. Smoke Testing

After deployment, Jenkins validates application availability using the health endpoint.

Example:

```
GET /health
```

---

## 8. Promotion and Rollback

Deployments to the Demo environment require manual approval.

If deployment validation fails, Helm rollback restores the previous stable release.

---

# Security Approach

Security controls implemented:

* No hardcoded credentials
* Jenkins Credential Store for secrets
* Kubernetes RBAC with least privilege
* Kubernetes Secrets for sensitive data
* TLS certificate management outside Git
* Container vulnerability scanning
* Immutable image tags

Detailed security documentation:

```
docs/security.md
```

---

# Deployment Strategy

Helm was selected because it provides:

* Reusable Kubernetes templates
* Environment-specific configurations
* Easier application promotion
* Consistent deployments

The same Helm chart is used for Lab and Demo environments.

Environment-specific values are managed through:

```
values-lab.yaml
values-demo.yaml
```

---

# Operational Support

The operational runbook explains:

* How to trigger deployments
* How to promote releases
* How to troubleshoot failures
* How to perform rollback procedures

Documentation:

```
docs/runbook.md
```

---

# Design Decisions and Tradeoffs

The following decisions were made:

* Jenkins Controller separated from build agents for scalability and security.
* Helm selected over raw manifests for reusable deployments.
* Immutable container tags selected instead of `latest`.
* Manual approval added before Demo promotion.
* Internal artifact storage used for controlled enterprise environments.

Detailed explanation:

```
docs/assumptions-and-tradeoffs.md
```

---

# Example Application

A sample Flask application is included under:

```
examples/app/
```

The application exposes:

```
GET /
GET /health
```

The health endpoint is used for Kubernetes probes and deployment validation.

---

# Future Improvements

Potential production enhancements include:

* Jenkins Shared Libraries
* HashiCorp Vault integration
* Argo CD GitOps deployment
* Prometheus and Grafana monitoring
* Terraform automation
* Kubernetes Network Policies
* Automated compliance checks

---

# Conclusion

This project demonstrates a practical Jenkins-based CI/CD platform design for an on-premises Kubernetes environment.

The solution provides secure, repeatable, and maintainable application delivery through automation, container security scanning, artifact management, Helm deployments, operational documentation, and rollback capabilities.
