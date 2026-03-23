# Arquitectura inicial — plataforma empornac-ai-dev-platform

Documento de **Fase 0**: visión de componentes, dependencias, supuestos, decisiones y parametrización pendiente. Complementa [01-arquitectura-general.md](01-arquitectura-general.md).

## 1. Objetivo completo

Demostrar un ciclo **moderno, automatizable y trazable** para desarrollar aplicaciones Oracle APEX: tickets (GLPI), código y exports en GitLab, pipelines con separación DEV/QA/PROD, y asistencia de agentes mediante MCP sin sustituir la gobernanza institucional (control de cambios, aprobaciones).

## 2. Componentes

| Componente | Rol en el laboratorio |
|------------|------------------------|
| **Oracle Database (Free / laboratorio)** | Motor de datos único o compartido con esquemas/prefijos por entorno |
| **Oracle APEX** | Desarrollo de aplicaciones (incluido en imagen de laboratorio cuando aplique) |
| **ORDS** | Publicación REST; en laboratorio puede ser **plantilla** hasta completar imagen o despliegue manual |
| **SQLcl** | Export/import APEX (full y split), scripts CI |
| **GitLab CE** | Repositorio, MR, issues, pipelines |
| **GitLab Runner** | Ejecución de jobs (Docker executor) |
| **GLPI** | Tickets, cambios, problemas; trazabilidad con ramas y commits |
| **MCP Oracle/APEX** | Herramientas para agentes: metadatos BD, exports APEX, ORDS, Git (stubs iniciales) |
| **MCP GLPI** | Creación y consulta de tickets, seguimientos, ITIL (stubs iniciales) |
| **Reverse proxy (opcional)** | Hostnames locales, TLS de demo |
| **Branding** | Paleta, tipografía, reglas UI para APEX y documentación |

## 3. Dependencias entre componentes

```text
GLPI (MariaDB)     GitLab CE ──► GitLab Runner
                         │
Oracle DB ◄── APEX       │ (clone, artefactos, deploy manual gates)
     ▲                   │
     └── ORDS (REST)     ▼
MCP Oracle ◄─────────── SQLcl / API / Git
MCP GLPI ─────────────► GLPI API (app token)
```

## 4. Supuestos

- Equipo de desarrollo en **macOS** con **Docker Desktop**.
- No se versionan secretos reales; solo `.env.example` y placeholders.
- La organización posee metodología formal; este repo **materializa** convenciones, no las define legalmente.
- Oracle de producción puede ser 12c; el laboratorio usa versión **moderna** para demostrar prácticas (export, ORDS, seguridad).

## 5. Decisiones técnicas críticas

1. **Orquestación:** `infra/docker-compose.yml` maestro + `docker-compose.override.example.yml` documentado para ajustes locales.
2. **MCP:** **Node.js + TypeScript** y `@modelcontextprotocol/sdk` — contratos tipados y un solo stack en `mcp/*`.
3. **Imagen Oracle de laboratorio:** por defecto **gvenzl/oracle-free** (documentado en instalación); validar **ARM64** en su equipo.
4. **GitLab local:** opcional vía **perfil Compose** `gitlab`; alternativa **GitLab SaaS** + runner local.
5. **Separación DEV/QA/PROD:** convive en laboratorio mediante **usuarios/esquemas**, **prefijos de aplicación** y **variables por carpeta** `environments/*`; promoción vía Git + pipeline con **manual gate** en PROD.

## 6. Riesgos (resumen)

Detalle y controles en [09-riesgos-y-controles.md](09-riesgos-y-controles.md): recursos del Mac, licencias/imágenes Oracle, fugas de secretos, drift entre documentación e infraestructura.

## 7. Parametrización pendiente (checklist para la institución)

- URL definitiva de GitLab (CE local vs SaaS).
- Política de nombres de esquemas/workspaces APEX por entorno.
- Versión objetivo de APEX/ORDS alineada a licenciamiento Oracle.
- Integración SMTP / LDAP para GitLab y GLPI (fuera del alcance mínimo del laboratorio).
- Clasificación de datos: si el laboratorio usará datos anonimizados.
- Etiquetas y estados de ticket GLPI obligatorios por tipo de cambio.
- Aprobadores para `deploy_prod` (GitLab: protected environments, manual jobs).

## 8. Roadmap de documentos relacionados

- [02-roadmap-de-implementacion.md](02-roadmap-de-implementacion.md)
- [11-guia-instalacion-laboratorio.md](11-guia-instalacion-laboratorio.md)
