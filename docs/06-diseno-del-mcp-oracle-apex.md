# Diseño del MCP Oracle / APEX / ORDS / Git

## Propósito

Exponer a agentes de IA operaciones **acotadas** sobre:

- Metadatos y consultas de base de datos Oracle (con separación lectura/escritura).
- Export y análisis de aplicaciones APEX.
- Descubrimiento y prueba de módulos ORDS.
- Diferencias en el repositorio Git.
- Resumen de Oracle Advisor (cuando exista integración).

**Ubicación del código:** [../mcp/oracle-apex/](../mcp/oracle-apex/).

## Transporte y stack

- **stdio** con servidor Node.js TypeScript.
- SDK: `@modelcontextprotocol/sdk`.

## Tools (contrato inicial)

| Tool | Intención | Estado iteración inicial |
|------|-----------|---------------------------|
| `db_list_objects` | Listar objetos por tipo/esquema | **Stub** |
| `db_describe_table` | Columnas, PK, FK | **Stub** |
| `db_describe_package` | Especificación de paquete | **Stub** |
| `db_run_sql_readonly` | SELECT validado / solo lectura | **Stub** — riesgo alto; requiere política estricta |
| `db_find_dependencies` | Dependencias entre objetos | **Stub** |
| `apex_export_app` | Export full vía SQLcl externo o API | **Stub** |
| `apex_export_app_split` | Export split | **Stub** |
| `apex_read_pages` | Metadatos de páginas desde export o vistas | **Stub** |
| `apex_analyze_page` | Heurísticas de calidad UI/lógica | **Stub** |
| `ords_list_modules` | Listado de módulos REST | **Stub** |
| `ords_test_module` | Prueba HTTP a endpoint | **Stub** |
| `git_diff_repo` | `git diff --stat` en repo local (`GIT_REPO_PATH` o cwd) | **Implementado** (sin remoto) |
| `advisor_run_summary` | Resumen de hallazgos | **Stub** |

## Resources

- `oracle://connection-info` — descripción no sensible de la conexión (sin contraseña).
- `apex://app/<id>/manifest` — resumen de app si existe export en repo.

## Prompts sugeridos

- Plantilla para revisar una página APEX frente a lineamientos UI.
- Plantilla para proponer DDL a partir de requerimiento funcional.

## Seguridad

- Cuentas de solo lectura donde sea posible.
- Lista blanca de sentencias SQL para `db_run_sql_readonly` si se implementa.
- No exponer cadenas de conexión completas en resources.

## Evolución

1. Implementar conexión Oracle real (thin driver o subprocess a SQLcl).
2. Integrar lectura de archivos bajo `apex/exports/`.
3. ORDS: llamadas HTTP autenticadas con credenciales de servicio.

## Referencia operativa

- [instalacion/08-servidores-mcp.md](instalacion/08-servidores-mcp.md)
- [../mcp/oracle-apex/README.md](../mcp/oracle-apex/README.md)
