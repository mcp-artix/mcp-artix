# GitHub local — modo puente hacia GitLab institucional

## Objetivo

Permitir que el equipo trabaje **desde ahora** con un repositorio en GitHub mientras llega el acceso al GitLab institucional, manteniendo:

- Convenciones de ramas y commits.
- Validación CI real (`validate`).
- Gates manuales para QA y PROD.
- Ruta de migración limpia a GitLab (sin rehacer todo).

## Alcance del modo puente

- **Activo ahora:** GitHub Actions (`validate`, `deploy_qa` manual, `deploy_prod` manual).
- **Se mantiene:** [.gitlab-ci.yml](../../.gitlab-ci.yml) como pipeline objetivo para GitLab institucional.
- **No incluido todavía:** despliegue real automatizado a QA/PROD.

## 1) Preflight local

```bash
bash scripts/github/preflight-github.sh
```

Si falla por falta de Git, continúe con el paso 2.

Atajo opcional (bootstrap completo):

```bash
bash scripts/github/bootstrap-local.sh --origin git@github.com:<org-o-usuario>/empornac-ai-dev-platform.git --crear-main
```

## 2) Inicializar Git local (si aún no existe)

```bash
git init -b develop
git add .
git commit -m "chore(repo): GLPI-0 inicializar repositorio local"
```

`GLPI-0` se usa solo como marcador temporal si aún no hay ticket formal.

## 3) Crear repo en GitHub y configurar remote

1. Crear el repositorio vacío en GitHub.
2. Configurar `origin`:

```bash
git remote add origin git@github.com:<org-o-usuario>/empornac-ai-dev-platform.git
# o HTTPS:
# git remote add origin https://github.com/<org-o-usuario>/empornac-ai-dev-platform.git
```

3. Publicar rama inicial:

```bash
git push -u origin develop
```

Si usa `main` como rama por defecto en GitHub, publíquela también:

```bash
git checkout -b main
git push -u origin main
git checkout develop
```

## 4) Activar CI en GitHub

Workflows incluidos:

- [../../.github/workflows/validate.yml](../../.github/workflows/validate.yml)
- [../../.github/workflows/deploy-qa.yml](../../.github/workflows/deploy-qa.yml)
- [../../.github/workflows/deploy-prod.yml](../../.github/workflows/deploy-prod.yml)

`validate` corre en `push` y `pull_request` para ramas de trabajo estándar.

Antes de cada push, puede ejecutar validación local equivalente:

```bash
bash ci/scripts/validate-local.sh --skip-mcp-build
```

## 5) Protección mínima de ramas

Configurar en GitHub (`Settings → Branches`):

- Rama `develop`:
  - Requerir Pull Request.
  - Requerir checks: `Validar convenciones y build MCP`.
- Rama `main`:
  - Requerir Pull Request.
  - Requerir checks: `Validar convenciones y build MCP`.
  - Requerir al menos 1 aprobación.

La plantilla de PR incluida en el repositorio ayuda a mantener trazabilidad:

- [../../.github/PULL_REQUEST_TEMPLATE.md](../../.github/PULL_REQUEST_TEMPLATE.md)

## 6) Gates manuales QA/PROD

Configurar entornos en GitHub (`Settings → Environments`):

- `qa`
- `prod`

Recomendado:

- `qa`: reviewers obligatorios (líder técnico o QA).
- `prod`: reviewers obligatorios + reglas más estrictas.

Los workflows `Deploy QA (Manual Puente)` y `Deploy PROD (Manual Puente)` usan esos entornos.

## 7) Variables y secretos (matriz puente)

Guardar en GitHub `Settings → Secrets and variables → Actions`.

| Variable | Tipo | Entorno sugerido | Uso |
|----------|------|------------------|-----|
| `ORACLE_HOST` | Secret | DEV/QA/PROD | Conexión Oracle en jobs futuros |
| `ORACLE_SERVICE` | Variable | DEV/QA/PROD | Servicio/PDB Oracle |
| `ORACLE_USER` | Secret | DEV/QA/PROD | Usuario técnico |
| `ORACLE_PASSWORD` | Secret | DEV/QA/PROD | Contraseña técnica |
| `GLPI_API_URL` | Variable | DEV/QA/PROD | Endpoint API GLPI |
| `GLPI_API_TOKEN` | Secret | DEV/QA/PROD | App token GLPI |
| `GLPI_USER_TOKEN` | Secret | DEV/QA/PROD | User token GLPI |
| `DEPLOY_TARGET` | Variable | QA/PROD | Selector de destino de despliegue |

Notas:

- En este puente, `validate` no requiere secretos para correr.
- No versionar valores reales en el repositorio.

## 8) Migración futura a GitLab institucional

Cuando exista acceso:

1. Cambiar remote a GitLab institucional.
2. Registrar runner GitLab.
3. Cargar variables CI en GitLab.
4. Mantener la misma lógica de validación (scripts ya compartidos en `ci/scripts/`).

## Checklist rápida

- [ ] `preflight-github.sh` exitoso
- [ ] `origin` configurado a GitHub
- [ ] workflows visibles en pestaña Actions
- [ ] protección de `develop` y `main` activa
- [ ] entornos `qa` y `prod` creados con revisión manual
- [ ] secretos definidos fuera del repositorio
- Prueba de protección de ramas
- Prueba de protección de ramas
