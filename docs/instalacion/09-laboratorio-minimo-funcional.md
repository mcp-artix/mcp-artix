# Sprint 1 — Laboratorio mínimo funcional

## Objetivo de este sprint

Dejar un flujo **coherente y ejecutable** para validar el laboratorio mínimo con:

- Oracle de laboratorio.
- GLPI (con MariaDB).
- MCP Oracle/APEX.
- MCP GLPI.

Sin rediseñar arquitectura general ni introducir secretos en el repositorio.

## Matriz de componentes reales vs stub

| Componente | Estado actual | Evidencia |
|------------|---------------|-----------|
| Oracle (`oracle`) | **Real y ejecutable** en Docker | [infra/docker-compose.yml](../../infra/docker-compose.yml) |
| GLPI (`mariadb` + `glpi`) | **Real y ejecutable** en Docker | [infra/docker-compose.yml](../../infra/docker-compose.yml) |
| MCP Oracle/APEX (servidor) | **Real** (arranca/compila) | [mcp/oracle-apex/src/index.ts](../../mcp/oracle-apex/src/index.ts) |
| MCP Oracle/APEX tools DB/APEX/ORDS | **Stub** | [docs/06-diseno-del-mcp-oracle-apex.md](../06-diseno-del-mcp-oracle-apex.md) |
| MCP Oracle/APEX `git_diff_repo` | **Implementado** | [mcp/oracle-apex/src/index.ts](../../mcp/oracle-apex/src/index.ts) |
| MCP GLPI (servidor) | **Real** (arranca/compila) | [mcp/glpi/src/index.ts](../../mcp/glpi/src/index.ts) |
| MCP GLPI `glpi_get_ticket` | **Implementado** (si tokens API existen) | [mcp/glpi/src/glpi-api.ts](../../mcp/glpi/src/glpi-api.ts) |
| MCP GLPI resto de tools | **Stub** | [docs/07-diseno-del-mcp-glpi.md](../07-diseno-del-mcp-glpi.md) |
| ORDS | **Plantilla / pendiente** | [infra/ords/README.md](../../infra/ords/README.md) |

## Checklist operativa de arranque local

1. Confirmar prerrequisitos:
   - Docker Desktop activo.
   - Recursos suficientes (ideal 16 GB RAM para laboratorio ampliado).
   - Node.js 20+ si se validarán MCP en host.
2. Inicializar variables:
   - `bash scripts/init-lab.sh`
   - Editar `infra/.env` solo con valores de laboratorio.
3. Arrancar laboratorio mínimo base:
   - `bash scripts/laboratorio/start-minimo.sh`
4. Validar salud base:
   - `bash scripts/laboratorio/validar-salud.sh`
5. Si se requiere probar MCP como contenedores Compose:
   - `bash scripts/laboratorio/start-minimo.sh --con-mcp-compose`
   - `bash scripts/laboratorio/validar-salud.sh --con-mcp-compose`
6. Si se requiere validar MCP en host:
   - `bash scripts/laboratorio/validar-salud.sh --con-mcp-build`

## Criterios de validación de salud

### Oracle

Se considera válido para este sprint cuando:

- `oracle` está en ejecución y healthcheck en `healthy`.
- El puerto configurado (`ORACLE_PORT`, por defecto 1521) responde.
- No hay errores fatales de arranque en logs:
  - `cd infra && docker compose logs --tail=120 oracle`

### GLPI

Se considera válido para este sprint cuando:

- `mariadb` está en ejecución y healthcheck en `healthy`.
- `glpi` está en ejecución.
- GLPI responde por HTTP en `http://localhost:${GLPI_HTTP_PORT}` con código 2xx/3xx.
- Si la BD está vacía, el asistente web de instalación aparece correctamente.

### MCP Oracle/APEX y MCP GLPI

Para este sprint se aceptan dos modos de validación:

1. **Compose (`--con-mcp-compose`)**:
   - `mcp-oracle-apex` y `mcp-glpi` en ejecución.
   - Variables de entorno de contenedor definidas en `infra/.env`:
     - `ORACLE_CONNECTION_MCP`
     - `GLPI_API_URL_MCP`
     - `GLPI_API_TOKEN`
     - `GLPI_USER_TOKEN`
2. **Host (`--con-mcp-build`)**:
   - Compilación TypeScript exitosa en `mcp/oracle-apex` y `mcp/glpi`.

## Comandos operativos de referencia

```bash
# Base (Oracle + GLPI)
bash scripts/laboratorio/start-minimo.sh
bash scripts/laboratorio/validar-salud.sh

# Base + MCP en Compose
bash scripts/laboratorio/start-minimo.sh --con-mcp-compose
bash scripts/laboratorio/validar-salud.sh --con-mcp-compose

# Validación MCP en host (build)
bash scripts/laboratorio/validar-salud.sh --con-mcp-build
```

## Brechas reales identificadas al cierre del sprint

- ORDS sigue como componente plantilla (no productivo aún).
- MCP Oracle/APEX mantiene tools DB/APEX/ORDS en estado stub.
- MCP GLPI solo tiene `glpi_get_ticket` implementada; el resto sigue en stub.
- No se incluye prueba automática SQL real contra Oracle en este sprint (solo salud de servicio).
- No se prioriza GitLab en Docker local; se mantiene recomendación de GitLab institucional en servidor dedicado.
