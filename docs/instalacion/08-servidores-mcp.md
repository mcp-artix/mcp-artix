# Servidores MCP (Oracle/APEX y GLPI)

## Objetivo

Ejecutar los servidores **Model Context Protocol** del repositorio para conectar agentes de IA (Cursor, Codex, etc.) con Oracle/APEX/ORDS/Git (MCP 1) y GLPI (MCP 2).

## Ubicación

- [../../mcp/oracle-apex/](../../mcp/oracle-apex/)
- [../../mcp/glpi/](../../mcp/glpi/)

Stack: **Node.js + TypeScript** y `@modelcontextprotocol/sdk`.

## Requisitos

- Node.js **20+**
- En la raíz de cada MCP: `npm install` y `npm run build`

## Variables de entorno

Cada proyecto incluye `.env.example`. Copiar a `.env` **local** (ignorado por Git):

```bash
cd mcp/oracle-apex
cp .env.example .env
cd ../glpi
cp .env.example .env
```

### MCP Oracle/APEX (ejemplos de nombres)

- Cadena o parámetros de conexión Oracle (solo lectura donde aplique).
- URL base de ORDS si se usan tools REST.
- Ruta al repositorio Git si se usa `git_diff_repo`.

### MCP GLPI

- URL base de GLPI (`https://glpi.example.com`).
- `GLPI_APP_TOKEN` y `GLPI_USER_TOKEN` para la API REST (**no** versionar). La tool `glpi_get_ticket` los usa si están configurados.

## Ejecución en desarrollo (stdio)

La mayoría de clientes MCP lanzan el servidor como subproceso:

```bash
cd mcp/oracle-apex
npm run start
```

Configure en su cliente la ruta a `node` y al `dist/index.js` o el script definido en `package.json`.

## Docker (opcional)

Los Dockerfiles bajo `mcp/*` sirven para **empaquetar** el servidor; muchos clientes esperan **stdio** en local. Si usa transporte HTTP/SSE según evolución del cliente, ajuste el comando y puertos documentados en el README de cada MCP.

Si decide ejecutar MCP como servicios Compose (`--profile mcp`), configure en `infra/.env`:

- `ORACLE_CONNECTION_MCP` (usando host `oracle` dentro de la red Docker).
- `GLPI_API_URL_MCP` (por defecto `http://glpi`).
- `GLPI_API_TOKEN` y `GLPI_USER_TOKEN` para la API GLPI.

## Estado de implementación

Muchas **tools** están como **stubs**: devuelven mensajes estructurados indicando que falta configuración o implementación. Esto es intencional en esta iteración ([../06-diseno-del-mcp-oracle-apex.md](../06-diseno-del-mcp-oracle-apex.md), [../07-diseno-del-mcp-glpi.md](../07-diseno-del-mcp-glpi.md)).

## Seguridad

- Principio de **mínimo privilegio** en cuentas Oracle y GLPI usadas por los MCP.
- Auditar qué agente puede invocar tools que ejecuten SQL o modifiquen tickets.

## Verificación operativa (Sprint 1)

```bash
bash scripts/laboratorio/validar-salud.sh --con-mcp-build
# o, si usa perfil mcp en Docker:
bash scripts/laboratorio/validar-salud.sh --con-mcp-compose
```
