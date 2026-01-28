# Infrastructure Environment – TEST

This repository contains the **TEST** environment configuration for applications managed via GitOps.

## Structure

| Path | Description |
|------|-------------|
| `values/devops-project/values.yaml` | Application values for TEST |
| `k8s/devops-project/` | Kubernetes manifests for TEST |

---

## GitOps Process

After merging a PR to this repository:

1. ArgoCD detects the new commit
2. Auto-sync is triggered
3. New application version is rolled out to `environment-test` namespace

---

## Promotion to PROD

The `promote-to-prod` workflow automatically:

1. Reads current image tag from `values/devops-project/values.yaml`
2. Updates the same tag in `infrastructure-env-prod` repository
3. Creates a Pull Request to PROD
4. After PR merge → ArgoCD PROD performs rollout

> **Note:** Workflow logic is defined in [ci-cd-templates/promote-environment.yml](https://github.com/devops-project-adrian-dmytryk/ci-cd-templates/blob/main/.github/workflows/promote-environment.yml)

---

## Related Repositories

| Repository | Purpose |
|------------|---------|
| `infrastructure-env-dev` | Promotion source |
| `ci-cd-templates` | Centralized CI/CD workflow templates |
| `infrastructure-env-prod` | Promotion target |
