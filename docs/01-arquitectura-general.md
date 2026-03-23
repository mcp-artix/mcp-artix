# Arquitectura general

## Visión

La plataforma **empornac-ai-dev-platform** modela un ecosistema donde el **código y los artefactos APEX** viven en **Git**, la **calidad y promoción** pasan por **GitLab CI/CD**, la **demanda y trazabilidad** nacen en **GLPI**, y los **agentes de IA** acceden a capacidades controladas vía **MCP**.

## Capas

1. **Experiencia y aplicaciones:** Oracle APEX (apps institucionales), ORDS para REST.
2. **Datos:** Oracle Database (laboratorio); esquemas o convenciones por entorno.
3. **DevOps:** GitLab (repositorio, MR, issues), Runner (jobs Docker).
4. **Gestión de servicio:** GLPI (tickets, cambios, problemas).
5. **Asistencia IA:** MCP Oracle/APEX y MCP GLPI (tools con stubs inicialmente).

## Flujo de datos principal

```text
Ticket GLPI → Rama feature → Commits → Pipeline (validate/export/package) → Deploy DEV/QA → Aprobación → Deploy PROD (manual)
```

## Despliegue físico (laboratorio)

- **Docker Desktop** en Mac: servicios definidos en [../infra/docker-compose.yml](../infra/docker-compose.yml).
- Separación lógica **DEV/QA/PROD** sin implicar tres datacenters: ver [03-flujo-dev-qa-prod.md](03-flujo-dev-qa-prod.md).

## Decisiones de diseño

| Tema | Elección |
|------|----------|
| MCP | TypeScript + SDK oficial MCP |
| Secretos | Variables de entorno / CI variables, nunca en Git |
| PROD | Sin despliegue automático sin aprobación explícita |
| Documentación | Español, enlazada desde README e infra |

## Documentos relacionados

- [00-arquitectura-inicial.md](00-arquitectura-inicial.md)
- [11-guia-instalacion-laboratorio.md](11-guia-instalacion-laboratorio.md)
