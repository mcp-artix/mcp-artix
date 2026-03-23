# Integración GLPI — metodología

GLPI es la **fuente operativa** de tickets, cambios y problemas enlazados al desarrollo.

## Flujo recomendado

1. **Ticket** de solicitud o cambio creado en GLPI.
2. **Rama** `feature/GLPI-<id>-...` en GitLab.
3. **Commits** con referencia `GLPI-<id>` en el asunto.
4. **MR** con plantilla [../.gitlab/merge_request_templates/default.md](../.gitlab/merge_request_templates/default.md).
5. Tras despliegue: actualizar estado del ticket y enlazar **pipeline** o **tag**.

## Configuración técnica del laboratorio

Ver [../docs/instalacion/06-glpi.md](../docs/instalacion/06-glpi.md) y [../infra/glpi/README.md](../infra/glpi/README.md).

## API para MCP

El servidor [../mcp/glpi/](../mcp/glpi/) consumirá la API REST con tokens configurados solo en entorno local o CI.

## ITIL

- **Problema:** causa raíz recurrente o incidente mayor.
- **Cambio:** toda promoción a PROD institucional (en demo, simulado con manual gates).
