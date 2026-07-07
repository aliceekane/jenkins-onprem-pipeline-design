# Assumptions and Tradeoffs

## Overview

This document explains the assumptions and engineering decisions made while designing the Jenkins-based CI/CD pipeline for the on-prem Lab and Demo environment.

---

# Infrastructure Assumptions

## Jenkins Environment

Assumptions:

- Jenkins Controller is hosted on-premises.
- Jenkins Agents are separate virtual machines.
- Agents have required build tools installed.
- Agents execute Docker builds and deployment tasks.

The Jenkins Controller is not used for builds to maintain reliability and security.

---

# Build Agent Design

## Assumption

Jenkins Agents are either:

- Static virtual machines
- Ephemeral build agents created when required

## Tradeoff

Static agents are simpler to manage but require manual maintenance.

Ephemeral agents provide better scalability but require additional automation.

---

# Kubernetes Availability

## Assumption

The Lab and Demo environments have Kubernetes clusters available.

Applications are deployed using Helm charts.

## Tradeoff

Helm was selected instead of raw Kubernetes manifests because:

- Templates are reusable
- Environment configuration is easier
- Application promotion is simplified

---

# Artifact Repository

## Assumption

Nexus Repository is available internally.

Container images are stored internally instead of relying only on public registries.

## Tradeoff

Internal repositories improve security and availability but require additional maintenance.

---

# Internet Access

## Assumption

The on-prem environment may have restricted internet access.

Base images and dependencies may be mirrored internally.

## Tradeoff

Internal mirrors improve reliability but require maintenance of approved images.

---

# Secrets Management

## Assumption

Secrets are managed outside Git.

Examples:

- Jenkins Credentials Store
- Kubernetes Secrets
- Enterprise secret management platforms

## Tradeoff

Centralized secret management improves security but requires additional administration.

---

# Image Tagging Strategy

## Decision

The pipeline uses immutable image tags.

Example:
application:build-25


## Reason

Immutable tags provide:

- Better traceability
- Easier rollback
- Improved release management

---

# Deployment Strategy

## Decision

Helm is used for Kubernetes deployments.

## Reason

Helm provides:

- Reusable templates
- Environment-specific values
- Consistent deployments

---

# Manual Approval

## Decision

Demo environment deployments require manual approval.

## Reason

This provides:

- Controlled releases
- Additional validation
- Protection against accidental customer-facing changes

---

# Summary

The design prioritizes reliability, security, repeatability, and operational simplicity while considering the limitations of an on-premises environment.