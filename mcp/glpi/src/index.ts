/**
 * Servidor MCP: GLPI (tickets, ITIL). Tools en stub salvo evolución futura.
 */
import { McpServer } from "@modelcontextprotocol/sdk/server/mcp.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";
import { z } from "zod";
import { obtenerTicketPorId } from "./glpi-api.js";
import { respuestaStubGlpi } from "./stub.js";

const server = new McpServer({
  name: "empornac-glpi",
  version: "0.1.0",
});

function reg(
  nombre: string,
  descripcion: string,
  schema: Record<string, z.ZodTypeAny>,
) {
  server.registerTool(
    nombre,
    { description: descripcion, inputSchema: schema },
    async () => respuestaStubGlpi(nombre),
  );
}

reg("glpi_create_ticket", "Crea un ticket en GLPI.", {
  titulo: z.string(),
  descripcion: z.string(),
  categoria: z.string().optional(),
});
reg("glpi_search_tickets", "Busca tickets con criterios.", {
  consulta: z.string(),
  limite: z.number().optional(),
});
reg("glpi_add_followup", "Añade seguimiento a un ticket.", {
  ticketId: z.number(),
  texto: z.string(),
});
reg("glpi_change_status", "Cambia estado del ticket.", {
  ticketId: z.number(),
  nuevoEstado: z.string(),
});
reg("glpi_assign_ticket", "Asigna ticket a técnico o grupo.", {
  ticketId: z.number(),
  asignadoA: z.string(),
});
reg("glpi_attach_file", "Adjunta archivo (multipart en implementación real).", {
  ticketId: z.number(),
  nombreArchivo: z.string(),
});
reg("glpi_create_problem", "Crea un problema ITIL.", {
  titulo: z.string(),
  descripcion: z.string(),
});
reg("glpi_create_change", "Crea un cambio ITIL.", {
  titulo: z.string(),
  descripcion: z.string(),
});
reg("glpi_link_parent_child", "Vincula ticket padre e hijo.", {
  padreId: z.number(),
  hijoId: z.number(),
});

server.registerTool(
  "glpi_get_ticket",
  {
    description:
      "Obtiene un ticket por ID vía API REST (requiere GLPI_BASE_URL, GLPI_APP_TOKEN, GLPI_USER_TOKEN).",
    inputSchema: {
      id: z.number().int().positive(),
    },
  },
  async ({ id }) => {
    const r = await obtenerTicketPorId(id);
    const cuerpo = r.ok
      ? { estado: "ok", id, ticket: r.ticket }
      : { estado: "error", id, mensaje: r.mensaje };
    return {
      content: [{ type: "text", text: JSON.stringify(cuerpo, null, 2) }],
    };
  },
);

server.registerResource(
  "glpi-config",
  "glpi://session/config",
  {
    title: "Configuración GLPI (sin secretos)",
    description: "URL base y presencia de token.",
  },
  async () => ({
    contents: [
      {
        uri: "glpi://session/config",
        mimeType: "application/json",
        text: JSON.stringify(
          {
            GLPI_BASE_URL: process.env.GLPI_BASE_URL ?? "no configurado",
            GLPI_APP_TOKEN_definido: Boolean(process.env.GLPI_APP_TOKEN),
            GLPI_USER_TOKEN_definido: Boolean(process.env.GLPI_USER_TOKEN),
          },
          null,
          2,
        ),
      },
    ],
  }),
);

server.registerPrompt(
  "crear_ticket_desde_analisis",
  {
    description: "Borrador de ticket GLPI a partir de análisis de impacto.",
    argsSchema: {
      analisis: z.string(),
      solicitante: z.string().optional(),
    },
  },
  async ({ analisis, solicitante }) => ({
    messages: [
      {
        role: "user",
        content: {
          type: "text",
          text: `Redacta un ticket GLPI en español (título, descripción, criterios de aceptación, riesgos) a partir de:\n\n${analisis}\n\nSolicitante sugerido: ${solicitante ?? "N/D"}`,
        },
      },
    ],
  }),
);

server.registerPrompt(
  "texto_cambio_cab",
  {
    description: "Borrador para comité de cambios (CAB).",
    argsSchema: {
      resumenTecnico: z.string(),
      ventana: z.string(),
    },
  },
  async ({ resumenTecnico, ventana }) => ({
    messages: [
      {
        role: "user",
        content: {
          type: "text",
          text: `Genera un texto de solicitud de cambio para CAB en español: impacto, rollback, pruebas, ventana ${ventana}. Contexto técnico:\n${resumenTecnico}`,
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
