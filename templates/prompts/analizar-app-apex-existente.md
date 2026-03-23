# Prompt: analizar aplicación APEX existente

Actúa como arquitecto APEX senior. Tienes acceso al repositorio y, si está configurado, al MCP Oracle/APEX.

**Objetivo:** producir un informe en **español** sobre la aplicación APEX **ID {{APP_ID}}** (workspace {{WORKSPACE}}).

**Incluye:**

1. Resumen de módulos funcionales inferidos desde exports bajo `apex/exports/` o desde descripción proporcionada.
2. Riesgos técnicos (SQL en origen, autorización, uso de dinámicas).
3. Deuda alineada a `docs/10-branding-y-lineamientos-ui.md` y `branding/ui-rules.md`.
4. Recomendaciones priorizadas (quick wins vs refactor).

**Restricciones:** no inventar pantallas no documentadas; indica supuestos explícitamente.
