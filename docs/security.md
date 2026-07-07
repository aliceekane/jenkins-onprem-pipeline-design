# Security Approach

## Secrets Management

No credentials, passwords, tokens, or private keys are stored in Git.

Secrets are managed through:

- Jenkins Credentials Store
- Kubernetes Secrets
- External secret management solutions if required

---

## Jenkins Security

Jenkins uses:

- Role-based access control
- Credential binding
- Restricted permissions for agents

---

## Container Security

Container images are scanned before publishing using Trivy.

Pipeline fails if critical vulnerabilities are detected.

---

## Kubernetes Security

Security controls include:

- RBAC
- Namespace isolation
- Least privilege service accounts
- Network restrictions

---

## TLS Management

TLS certificates are managed separately from application code.

Certificates are stored securely and injected during deployment.

---

## Image Management

Images use immutable tags:

Example:


