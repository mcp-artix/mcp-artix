# Estrategia CI/CD

## Objetivos

- **Detectar errores** temprano (validación de rama, mensaje de commit, estructura).
- **Versionar artefactos** APEX (export) de forma reproducible.
- **No desplegar PROD** sin **aprobación explícita** (job `manual` en GitLab).

## Archivo principal

[../.gitlab-ci.yml](../.gitlab-ci.yml) define stages:

1. **validate** — scripts de convención; opcionalmente linters.
2. **export_apex** — generación de export (requiere Runner con SQLcl y secretos).
3. **package** — empaquetado de artefactos (zip/tar de `apex/exports` o similar).
4. **deploy_dev** — despliegue a entorno DEV (manual o automático según política).
5. **deploy_qa** — **manual** por defecto.
6. **deploy_prod** — **siempre manual** y recomendado con **protected environment**.

## Modo puente con GitHub (temporal)

Si no hay acceso a GitLab institucional, este repositorio incluye workflows equivalentes para avanzar sin bloquear:

- `validate`: [../.github/workflows/validate.yml](../.github/workflows/validate.yml)
- `deploy_qa` manual: [../.github/workflows/deploy-qa.yml](../.github/workflows/deploy-qa.yml)
- `deploy_prod` manual: [../.github/workflows/deploy-prod.yml](../.github/workflows/deploy-prod.yml)

Guía operativa: [instalacion/10-github-modo-puente.md](instalacion/10-github-modo-puente.md).
Validación local recomendada antes de push: `bash ci/scripts/validate-local.sh --skip-mcp-build`.

## Secretos

Configurar en GitLab **CI/CD Variables**:

- Prefijo sugerido: `ORACLE_*`, `GLPI_*`, `DEPLOY_*`
- Marcar como **masked** y **protected** en ramas protegidas.

Nunca almacenar en el repositorio.

## Runners

- Executor **docker** documentado en [instalacion/05-gitlab-runner.md](instalacion/05-gitlab-runner.md).
- Tags: alinear `tags:` en `.gitlab-ci.yml` con los del Runner real.

## Gates manuales

| Stage | Gate |
|-------|------|
| deploy_qa | Aprobación de líder técnico o QA |
| deploy_prod | Aprobación de cambio + ventana + doble control |

## Artefactos

- Retención acotada en GitLab para exports grandes.
- Considerar **Git LFS** solo si la política del equipo lo permite.

## Integración con GLPI

- El pipeline puede añadir comentario al ticket vía API (futuro); mientras tanto, enlace manual en el ticket al pipeline.

## Referencias

- [03-flujo-dev-qa-prod.md](03-flujo-dev-qa-prod.md)
- [../ci/README.md](../ci/README.md)
