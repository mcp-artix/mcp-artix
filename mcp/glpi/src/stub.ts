/** Respuesta estándar para tools GLPI no implementadas. */
export function respuestaStubGlpi(tool: string, detalle?: string) {
  const cuerpo = {
    estado: "stub" as const,
    tool,
    mensaje:
      detalle ??
      "Implementación pendiente. Ver docs/07-diseno-del-mcp-glpi.md y README del MCP.",
  };
  return {
    content: [{ type: "text" as const, text: JSON.stringify(cuerpo, null, 2) }],
  };
}
