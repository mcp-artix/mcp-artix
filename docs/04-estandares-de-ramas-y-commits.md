# Estándares de ramas y commits

## Modelo de ramas

| Rama / patrón | Origen | Destino típico | Uso |
|---------------|--------|----------------|-----|
| `main` | — | — | Línea de producción demostrable; solo merges vía MR/release/hotfix |
| `develop` | — | — | Integración continua; HEAD compilable |
| `feature/<ticket>-<slug>` | `develop` | `develop` | Nueva funcionalidad vinculada a ticket GLPI |
| `bugfix/<ticket>-<slug>` | `develop` | `develop` | Corrección no urgente |
| `release/<versión>` | `develop` | `main` + `develop` | Congelación y preparación de versión |
| `hotfix/<ticket>-<slug>` | `main` | `main` + `develop` | Corrección urgente en producción |

**Ejemplos de nombre:**

- `feature/GLPI-142-export-split-apex`
- `hotfix/GLPI-901-error-login`

El pipeline valida el patrón con [../ci/scripts/validate-branch-name.sh](../ci/scripts/validate-branch-name.sh) (cuando se invoque en CI).

## Commits

Formato recomendado (Convencional + ticket):

```text
<tipo>(<ámbito opcional>): GLPI-<id> <descripción breve en español>

Cuerpo opcional: contexto, impacto, enlace a MR.
```

**Tipos:** `feat`, `fix`, `docs`, `ci`, `chore`, `refactor`, `test`.

**Ejemplo:**

```text
feat(apex): GLPI-240 agregar página de listado de requerimientos

Export split actualizado bajo apex/exports/app-100/
```

### Reglas

- Un commit debe ser **reversible** y **comprensible** sin contexto externo mínimo.
- No mezclar cambios no relacionados en un mismo commit.
- Referenciar **siempre** el ticket GLPI si existe política institucional.

La validación de formato puede aplicarse con [../ci/scripts/validate-commit-message.sh](../ci/scripts/validate-commit-message.sh) en merge requests.

## Merge requests

- Título alineado al ticket: `[GLPI-123] Descripción breve`
- Checklist en plantilla: pruebas, exports APEX, actualización de docs, riesgos.
- **Sin merge** a `main` sin revisión y sin pipeline verde (salvo excepción documentada).

## Tags y releases

- Tags `vX.Y.Z` en `main` tras release aprobado.
- Notas de release enlazadas a tickets cerrados y cambios de GLPI.

## Referencias

- [05-estrategia-ci-cd.md](05-estrategia-ci-cd.md)
- [../templates/gitlab/merge_request_templates/default.md](../templates/gitlab/merge_request_templates/default.md)
