# Entorno QA (calidad)

## Propósito

Validación funcional, regresión y UAT controlado. Debe ser **estable** durante la ventana de pruebas de cada release.

## Convenciones de naming

| Artefacto | Convención sugerida |
|-----------|---------------------|
| Esquema Oracle | `REQ_QA` |
| Workspace APEX | `EMPORNAC_QA` |
| App APEX | Mismo número de app que DEV si se usa promoción por export, o ID distinto documentado |
| ORDS | `/ords/qa/` (tras proxy) |

## Variables

[.env.example](.env.example)

## Estrategia de despliegue

- Job `deploy_qa` en GitLab: **manual** por defecto, tras artefacto de `package` o tag de release candidato.
- Entrada: rama `release/*` o `develop` según política.

## Seguridad

- Separar credenciales de DEV.
- Datos de prueba sin información clasificada.

## Relación con GLPI

Ticket en **Pendiente QA** / **En prueba**; registro de defectos como sub-tareas o nuevos tickets.
