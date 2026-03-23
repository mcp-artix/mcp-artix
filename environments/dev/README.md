# Entorno DEV (desarrollo)

## Propósito

Integración continua del equipo: desarrollo activo de APEX y PL/SQL, pruebas informales, datos **sintéticos o anonimizados**.

## Convenciones de naming

| Artefacto | Convención sugerida |
|-----------|---------------------|
| Esquema Oracle | `REQ_DEV` o prefijo `DEV_` |
| Workspace APEX | `EMPORNAC_DEV` |
| App APEX (demo) | ID **100** (laboratorio; ajustable) |
| Rama Git | `develop`, `feature/*` |

## Variables

Ver [.env.example](.env.example). Estas variables son referencia para pipelines y scripts; la conexión real la define el Runner o el desarrollador local.

## Estrategia de despliegue

- Merge a `develop` → job `deploy_dev` (manual o automático según [.gitlab-ci.yml](../.gitlab-ci.yml)).
- Sin promoción directa a QA/PROD desde aquí sin MR/release.

## Seguridad

- Credenciales débiles aceptables **solo** en red aislada de laboratorio.
- No copiar volúmenes de DEV a PROD sin sanitizar.

## Relación con GLPI

Ticket en estado **En desarrollo** o **Integración**; enlace en MR.
