# Flujo DEV, QA y PROD

## Principios

1. **Un solo repositorio** como fuente de verdad del DDL versionado, exports APEX (split/full según política), scripts y configuración declarativa.
2. **Promoción por calidad:** lo que llega a QA y PROD ha pasado por validaciones y revisión humana donde corresponda.
3. **Trazabilidad:** ticket GLPI + MR + pipeline + registro de despliegue (aunque el registro sea manual en el laboratorio).

## Entornos (laboratorio)

| Entorno | Propósito | Quién actúa | Datos |
|---------|-----------|-------------|--------|
| **DEV** | Desarrollo activo, experimentación | Desarrolladores | Sintéticos o anonimizados |
| **QA** | Pruebas funcionales, regresión, UAT piloto | QA + desarrollo | Subconjunto controlado |
| **PROD** | Demostración estable o piloto controlado | Operaciones / líder técnico | Máxima restricción |

Las carpetas [../environments/dev](../environments/dev), [../environments/qa](../environments/qa) y [../environments/prod](../environments/prod) documentan variables y convenciones.

## Ramas y promoción

- Integración continua en **`develop`** → despliegue a **DEV** (automático o manual según pipeline).
- **Release** desde `develop` vía rama `release/*` o tag → **QA**.
- **Merge a `main`** (o tag de release aprobado) → **PROD** solo con **job manual** aprobado.

Detalle en [04-estandares-de-ramas-y-commits.md](04-estandares-de-ramas-y-commits.md) y [05-estrategia-ci-cd.md](05-estrategia-ci-cd.md).

## Actividades por fase del ciclo de vida

```text
Solicitud (GLPI) → Análisis → Diseño técnico → Desarrollo (rama feature) → Code review → CI → Deploy DEV
→ Pruebas → Deploy QA (manual/automático) → UAT / aceptación → Change record → Deploy PROD (manual) → Cierre ticket
```

## Hotfix

- Rama `hotfix/*` desde **`main`**, parche mínimo, pipeline acelerado, **doble merge** a `main` y `develop` al integrar.

## Separación técnica en Oracle/APEX

- **Esquemas distintos** o **prefijos** de objetos por entorno.
- **Exports APEX** distintos o mismos números de app en workspaces separados (documentar decisión institucional).
- **ORDS**: mapeos o esquemas de publicación separados; no mezclar URLs de QA con datos de PROD.

## GLPI

- Ticket de **cambio** para PROD.
- **Problema** si hay incidente post-despliegue.
- Enlace en comentarios del MR al ID del ticket.

## Referencias

- [08-guia-de-demo.md](08-guia-de-demo.md)
- [../glpi/README.md](../glpi/README.md)
