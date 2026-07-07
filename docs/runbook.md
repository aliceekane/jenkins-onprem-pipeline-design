# CI/CD Operational Runbook

## Trigger Pipeline

The pipeline can be triggered by:

- Git commit
- Pull request merge
- Manual Jenkins execution

---

# Deployment Process

1. Jenkins starts pipeline.
2. Code is checked out.
3. Tests execute.
4. Docker image is created.
5. Image is scanned.
6. Image is pushed to Nexus.
7. Helm deploys application.

---

# Promote to Demo

After successful Lab deployment:

1. Review smoke test results.
2. Approve Jenkins promotion stage.
3. Deploy the approved image to Demo environment.

---

# Rollback Procedure

If deployment fails:

Run:

Verify:

- Pod status
- Application logs
- Kubernetes events

---

# Troubleshooting

Check:

## Jenkins

- Pipeline logs
- Agent availability
- Credentials

## Kubernetes

Commands:

## Networking

Verify:

- DNS resolution
- Ingress configuration
- TLS certificates
