# Diseño del MCP GLPI (tickets e ITIL)

## Propósito

Permitir que agentes de IA **crean y consultan** trabajo en GLPI de forma alineada a la metodología: tickets, seguimientos, estados, asignaciones, cambios, problemas y vínculos padre/hijo.

**Ubicación del código:** [../mcp/glpi/](../mcp/glpi/).

## Autenticación

GLPI expone API REST en versiones recientes. Se usará **token de aplicación** o **usuario + token** según configuración institucional. Los valores viven en variables de entorno del MCP (ver `mcp/glpi/.env.example`).

## Tools (contrato inicial)

| Tool | Intención | Estado iteración inicial |
|------|-----------|---------------------------|
| `glpi_create_ticket` | Alta de ticket | **Stub** |
| `glpi_get_ticket` | Detalle por ID vía API REST | **Implementado** si `GLPI_*` están configurados; si no, error descriptivo |
| `glpi_search_tickets` | Búsqueda con filtros | **Stub** |
| `glpi_add_followup` | Comentario seguimiento | **Stub** |
| `glpi_change_status` | Cambio de estado | **Stub** |
| `glpi_assign_ticket` | Asignación a técnico/grupo | **Stub** |
| `glpi_attach_file` | Adjunto (multipart) | **Stub** |
| `glpi_create_problem` | Alta problema ITIL | **Stub** |
| `glpi_create_change` | Alta cambio ITIL | **Stub** |
| `glpi_link_parent_child` | Relación entre ítems | **Stub** |

## Resources

- `glpi://session/config` — URL base y versión API (sin token).
- `glpi://ticket/<id>` — vista resumida cuando esté implementado.

## Prompts sugeridos

- Crear ticket desde análisis de impacto.
- Generar texto de cambio estándar para comité de CAB (borrador).

## Consideraciones

- **Idempotencia:** crear ticket dos veces por error del agente es costoso; preferir confirmación humana o parámetros estrictos.
- **Permisos:** usuario API con alcance mínimo (solo entidades necesarias).
- **RGPD / datos personales:** no devolver campos sensibles en resources públicas del MCP.

## Evolución

1. Implementar cliente HTTP con manejo de errores GLPI.
2. Mapear IDs de categorías/entidades a constantes configurables.
3. Tests de contrato contra instancia Docker de laboratorio.

## Referencia operativa

- [instalacion/08-servidores-mcp.md](instalacion/08-servidores-mcp.md)
- [../mcp/glpi/README.md](../mcp/glpi/README.md)
