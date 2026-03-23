# MCP Oracle / APEX / ORDS / Git

Servidor **Model Context Protocol** para asistir a agentes en tareas relacionadas con Oracle, APEX, ORDS y el repositorio Git.

## Estado

**Iteración inicial:** casi todas las **tools** son **stubs** que devuelven JSON con `estado: "stub"`. Los **prompts** y **resources** básicos están operativos a nivel MCP.

## Requisitos

- Node.js 20+
- `npm install` y `npm run build`

## Configuración

```bash
cp .env.example .env
# Editar valores de laboratorio
```

Variables: ver `.env.example`. Opcionalmente `config.example.json` para evolución futura.

## Ejecución

**stdio (recomendado para Cursor / clientes MCP):**

```bash
npm run build
npm run start
```

**Desarrollo con tsx:**

```bash
npm run dev
```

## Docker

```bash
docker build -t empornac/mcp-oracle-apex:local .
```

En Docker, stdio requiere `docker run -i`; muchos equipos ejecutan el MCP en el **host**. Ver [../../docs/instalacion/08-servidores-mcp.md](../../docs/instalacion/08-servidores-mcp.md).

## Tools (contrato)

| Tool | Descripción breve |
|------|-------------------|
| `db_list_objects` | Listar objetos |
| `db_describe_table` | Describir tabla |
| `db_describe_package` | Describir paquete |
| `db_run_sql_readonly` | SQL solo lectura (riesgo) |
| `db_find_dependencies` | Dependencias |
| `apex_export_app` | Export full |
| `apex_export_app_split` | Export split |
| `apex_read_pages` | Metadatos de páginas |
| `apex_analyze_page` | Análisis heurístico |
| `ords_list_modules` | Módulos ORDS |
| `ords_test_module` | Probar módulo |
| `git_diff_repo` | Diff Git |
| `advisor_run_summary` | Advisor |

## Resources

- `oracle://connection-info`
- `apex://app/100/manifest`

## Prompts

- `revisar_pagina_apex`
- `proponer_ddl_requerimiento`

## Documentación de diseño

[../../docs/06-diseno-del-mcp-oracle-apex.md](../../docs/06-diseno-del-mcp-oracle-apex.md)
