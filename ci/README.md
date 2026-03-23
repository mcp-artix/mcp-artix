# CI — scripts auxiliares

Scripts invocados desde [.gitlab-ci.yml](../.gitlab-ci.yml):

- [scripts/validate-branch-name.sh](scripts/validate-branch-name.sh)
- [scripts/validate-commit-message.sh](scripts/validate-commit-message.sh)
- [scripts/validate-repo-structure.sh](scripts/validate-repo-structure.sh)
- [scripts/validate-local.sh](scripts/validate-local.sh)

## SQLcl (export APEX)

- [Dockerfile.sqlcl](Dockerfile.sqlcl) — plantilla de imagen CI.
- [sqlcl/README.md](sqlcl/README.md) — notas para integrar export real en el pipeline.

## Uso local

```bash
bash ci/scripts/validate-branch-name.sh "$(git rev-parse --abbrev-ref HEAD)"
echo "feat(apex): GLPI-1 ejemplo" | bash ci/scripts/validate-commit-message.sh
bash ci/scripts/validate-repo-structure.sh .
bash ci/scripts/validate-local.sh --skip-mcp-build
```

## GitHub (modo puente)

Existe workflow de validación equivalente en:

- [../.github/workflows/validate.yml](../.github/workflows/validate.yml)
