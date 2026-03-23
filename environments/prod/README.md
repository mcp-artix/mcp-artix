# Entorno PROD (producción demostrativa)

## Propósito

Entorno **estable** para demostración institucional o piloto controlado. **No** es producción corporativa crítica salvo decisión explícita de la organización.

## Convenciones de naming

| Artefacto | Convención sugerida |
|-----------|---------------------|
| Esquema Oracle | `REQ_PROD` |
| Workspace APEX | `EMPORNAC_PROD` |
| ORDS | `/ords/prod/` |

## Variables

[.env.example](.env.example)

## Estrategia de despliegue

- Solo vía job **`deploy_prod`** con **aprobación manual** y, en institución real, **ventana de cambio** y ticket GLPI tipo **Cambio**.
- Merge a `main` o tag `v*` según [docs/04-estandares-de-ramas-y-commits.md](../../docs/04-estandares-de-ramas-y-commits.md).

## Seguridad

- Credenciales fuertes y rotación.
- Backups antes de cada despliegue.
- Sin datos personales reales en demos genéricas.

## Relación con GLPI

Cierre de **Cambio**, actualización de **CMDB** (si aplica) y enlace al tag de release en Git.
