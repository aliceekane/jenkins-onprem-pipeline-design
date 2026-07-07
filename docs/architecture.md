# Jenkins On-Prem CI/CD Architecture

## Overview

This document describes the architecture of a Jenkins-based CI/CD pipeline designed for an on-premises Lab and Demo environment.

The architecture supports building, testing, scanning, publishing, and deploying containerized applications.

---

# Pipeline Flow

1. Developer commits code to Git repository.
2. Jenkins Controller detects the change.
3. Jenkins assigns execution to a Jenkins Agent.
4. Agent performs:
   - Source checkout
   - Application validation
   - Unit testing
   - Docker image build
   - Security scanning
5. Approved images are pushed to Nexus Repository.
6. Helm deploys the application into Kubernetes.
7. Jenkins performs smoke testing.
8. Approved releases are promoted to Demo.

---

# Components

## Git Repository

Stores:

- Application source code
- Jenkinsfile
- Helm charts
- Deployment scripts
- Documentation

---

## Jenkins Controller

Responsibilities:

- Pipeline orchestration
- Job scheduling
- Credential management
- Build monitoring

The controller does not execute builds.

---

## Jenkins Agents

Agents perform:

- Docker builds
- Security scans
- Deployment commands
- Testing

Separating agents improves scalability and security.

---

## Nexus Repository

Nexus stores container images using immutable tags.

Example:

Using versioned tags supports rollback.

---

## Kubernetes Environment

Applications are deployed using Helm charts.

Components:

- Deployment
- Service
- Ingress
- ConfigMap

---

## Ingress and DNS

NGINX Ingress manages incoming traffic.

Internal DNS resolves application endpoints.

TLS certificates provide encrypted communication.

---

## Rollback Strategy

If deployment validation fails:

- Jenkins marks deployment unsuccessful.
- Helm rollback restores the previous release.
- Logs are reviewed through Jenkins and Kubernetes.
