/**
 * Respuesta estándar para tools aún no implementadas (MCP Oracle/APEX).
 */
export function respuestaStub(tool: string, detalle?: string) {
  const cuerpo = {
    estado: "stub" as const,
    tool,
    mensaje:
      detalle ??
      "Implementación pendiente. Consulte docs/06-diseno-del-mcp-oracle-apex.md y README del MCP.",
  };
  return {
    content: [{ type: "text" as const, text: JSON.stringify(cuerpo, null, 2) }],
  };
}
