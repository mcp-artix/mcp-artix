# Prompt: preparar release

Versión objetivo: **{{VERSION}}** (semver)

Con el estado actual del repositorio y los merges en `develop`:

1. Propón nombre de rama `release/{{VERSION}}`.
2. Lista checklist pre-release: exports APEX, migraciones `database/migrations/`, variables `environments/qa`.
3. Borrador de notas de release en español (cambios visibles al usuario y técnicos).
4. Señala qué jobs de GitLab deben ejecutarse manualmente antes de QA.

Referencia: `docs/03-flujo-dev-qa-prod.md`.
