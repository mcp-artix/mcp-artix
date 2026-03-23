# MCP GLPI

Servidor MCP para **tickets** y objetos ITIL en GLPI mediante la API REST.

## Estado

**Stubs** en todas las tools; **resources** y **prompts** mínimos activos.

## Configuración

```bash
cp .env.example .env
```

- `GLPI_BASE_URL` — URL base (p. ej. `http://localhost:8081`).
- `GLPI_APP_TOKEN` y `GLPI_USER_TOKEN` — API REST (no versionar). Ver [../../docs/instalacion/06-glpi.md](../../docs/instalacion/06-glpi.md).

## Tools implementadas (parcial)

- **`glpi_get_ticket`:** llama a `GET .../Ticket/:id` tras `initSession` si las variables están definidas.
- **Resto:** siguen en stub hasta siguiente iteración.

## Ejecución

```bash
npm install
npm run build
npm run start
```

## Tools previstas

`glpi_create_ticket`, `glpi_get_ticket`, `glpi_search_tickets`, `glpi_add_followup`, `glpi_change_status`, `glpi_assign_ticket`, `glpi_attach_file`, `glpi_create_problem`, `glpi_create_change`, `glpi_link_parent_child`.

## Documentación

[../../docs/07-diseno-del-mcp-glpi.md](../../docs/07-diseno-del-mcp-glpi.md)  
[../../docs/instalacion/08-servidores-mcp.md](../../docs/instalacion/08-servidores-mcp.md)

## Docker

```bash
docker build -t empornac/mcp-glpi:local .
```
