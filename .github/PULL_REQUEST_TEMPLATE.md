## Resumen

Describa brevemente qué cambia y por qué.

## Ticket GLPI asociado

- ID: `GLPI-<id>`
- Enlace:

## Tipo de cambio

- [ ] `feature`
- [ ] `bugfix`
- [ ] `hotfix`
- [ ] `release`
- [ ] `docs/ci/chore`

## Evidencia de validación

- [ ] Workflow `Validate (Puente GitHub)` en verde.
- [ ] Validación local ejecutada (`bash ci/scripts/validate-local.sh --skip-mcp-build` o equivalente).
- [ ] Si aplica, build MCP Oracle/APEX correcto.
- [ ] Si aplica, build MCP GLPI correcto.

## Impacto por entorno

- DEV:
- QA:
- PROD:

## Riesgos y rollback

- Riesgos principales:
- Plan de rollback:

## Checklist de seguridad y gobernanza

- [ ] No se versionaron secretos ni credenciales reales.
- [ ] Se respeta separación DEV/QA/PROD.
- [ ] Documentación actualizada si cambió comportamiento técnico.
- [ ] Si toca QA/PROD, se usará gate manual correspondiente.
