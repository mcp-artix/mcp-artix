/**
 * Servidor MCP: Oracle, APEX, ORDS, Git (laboratorio empornac).
 * Transporte stdio. La mayoría de tools son stubs con contrato estable.
 */
import { McpServer } from "@modelcontextprotocol/sdk/server/mcp.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";
import { z } from "zod";
import { ejecutarGitDiffStat, resolverRutaRepo } from "./git-diff.js";
import { respuestaStub } from "./stub.js";

const vacio = z.object({});

const server = new McpServer({
  name: "empornac-oracle-apex",
  version: "0.1.0",
});

function regStub(
  nombre: string,
  descripcion: string,
  schema: z.ZodRawShape = {},
) {
  server.registerTool(
    nombre,
    {
      description: descripcion,
      inputSchema: schema,
    },
    async () => respuestaStub(nombre),
  );
}

regStub(
  "db_list_objects",
  "Lista objetos Oracle por tipo y esquema (pendiente: conexión JDBC/SQLcl).",
  { esquema: z.string().optional(), tipo: z.string().optional() },
);
regStub(
  "db_describe_table",
  "Describe columnas y restricciones de una tabla.",
  { esquema: z.string().optional(), tabla: z.string() },
);
regStub(
  "db_describe_package",
  "Muestra especificación resumida de un paquete PL/SQL.",
  { esquema: z.string().optional(), paquete: z.string() },
);
regStub(
  "db_run_sql_readonly",
  "Ejecuta SQL en modo solo lectura (requiere política estricta antes de implementar).",
  { sql: z.string() },
);
regStub(
  "db_find_dependencies",
  "Busca dependencias entre objetos Oracle.",
  { esquema: z.string().optional(), objeto: z.string() },
);
regStub(
  "apex_export_app",
  "Export full de aplicación APEX vía SQLcl u orquestación externa.",
  { applicationId: z.number() },
);
regStub(
  "apex_export_app_split",
  "Export split de aplicación APEX.",
  { applicationId: z.number() },
);
regStub(
  "apex_read_pages",
  "Lee metadatos de páginas desde export en repo o vistas APEX.",
  { applicationId: z.number(), pageId: z.number().optional() },
);
regStub(
  "apex_analyze_page",
  "Análisis heurístico de una página APEX.",
  { applicationId: z.number(), pageId: z.number() },
);
regStub(
  "ords_list_modules",
  "Lista módulos REST publicados en ORDS.",
  vacio.shape,
);
regStub(
  "ords_test_module",
  "Prueba un endpoint ORDS (GET/POST) con credenciales de servicio.",
  { rutaRelativa: z.string(), metodo: z.enum(["GET", "POST"]).optional() },
);
regStub(
  "advisor_run_summary",
  "Resumen de Oracle Advisor / quality checks (integración futura).",
  vacio.shape,
);

server.registerTool(
  "git_diff_repo",
  {
    description:
      "Resumen `git diff --stat` en el repositorio local (GIT_REPO_PATH o cwd). Sin acceso a remoto.",
    inputSchema: {
      ref: z
        .string()
        .optional()
        .describe("Referencia opcional (ej. HEAD~1 o rama)"),
    },
  },
  async ({ ref }) => {
    const repo = resolverRutaRepo();
    const r = ejecutarGitDiffStat(repo, ref);
    const cuerpo = {
      estado: r.ok ? "ok" : "error",
      rutaRepo: repo,
      ref: ref ?? "(working tree vs índice)",
      salida: r.salida,
      error: r.error,
    };
    return {
      content: [
        {
          type: "text",
          text: JSON.stringify(cuerpo, null, 2),
        },
      ],
    };
  },
);

server.registerResource(
  "oracle-connection",
  "oracle://connection-info",
  {
    title: "Metadatos de conexión Oracle",
    description: "Sin contraseñas; valores tomados de entorno.",
  },
  async () => {
    const texto = JSON.stringify(
      {
        ORACLE_CONNECTION_definida: Boolean(process.env.ORACLE_CONNECTION),
        ORDS_BASE_URL: process.env.ORDS_BASE_URL ?? "no configurado",
      },
      null,
      2,
    );
    return {
      contents: [
        {
          uri: "oracle://connection-info",
          mimeType: "application/json",
          text: texto,
        },
      ],
    };
  },
);

server.registerResource(
  "apex-app-manifest",
  "apex://app/100/manifest",
  {
    title: "Manifiesto demo app 100",
    description: "Placeholder hasta existir export en apex/exports.",
  },
  async () => ({
    contents: [
      {
        uri: "apex://app/100/manifest",
        mimeType: "application/json",
        text: JSON.stringify(
          {
            applicationId: 100,
            nombre: "Sistema de Gestión de Requerimientos Internos (demo)",
            estado: "pendiente_import",
          },
          null,
          2,
        ),
      },
    ],
  }),
);

server.registerPrompt(
  "revisar_pagina_apex",
  {
    description: "Plantilla para revisar una página APEX frente a lineamientos UI.",
    argsSchema: {
      applicationId: z.string(),
      pageId: z.string(),
    },
  },
  async ({ applicationId, pageId }) => ({
    messages: [
      {
        role: "user",
        content: {
          type: "text",
          text: `Actúa como revisor técnico APEX. Analiza la página ${pageId} de la aplicación ${applicationId} según branding institucional, accesibilidad WCAG AA y separación de lógica en paquetes PL/SQL. Lista riesgos y mejoras priorizadas.`,
        },
      },
    ],
  }),
);

server.registerPrompt(
  "proponer_ddl_requerimiento",
  {
    description: "Genera borrador de DDL alineado al módulo de requerimientos.",
    argsSchema: { requerimientoFuncional: z.string() },
  },
  async ({ requerimientoFuncional }) => ({
    messages: [
      {
        role: "user",
        content: {
          type: "text",
          text: `A partir del siguiente requerimiento, propón tablas, constraints e índices en Oracle (español en comentarios SQL):\n\n${requerimientoFuncional}`,
        },
      },
    ],
  }),
);

async function main() {
  const transport = new StdioServerTransport();
  await server.connect(transport);
}

main().catch((e) => {
  console.error(e);
  process.exit(1);
});
