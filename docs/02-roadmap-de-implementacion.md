# Roadmap de implementación

Hoja de ruta por **fases** para evolucionar el laboratorio hacia un entorno institucional controlado. Las fases 0–13 de la iteración inicial cubren **estructura, documentación, plantillas Docker, CI/CD base y MCP stub**.

## Fase actual (en curso)

- Conectar repositorio al **GitLab en servidor dedicado** y registrar **Runner** ([instalacion/04-gitlab-servidor-dedicado.md](instalacion/04-gitlab-servidor-dedicado.md)).
- Validar **Oracle + GLPI** en Docker en hardware objetivo.
- MCP: `git_diff_repo` y `glpi_get_ticket` con **implementación inicial**; resto de tools GLPI siguen en stub.

## Fase A — Laboratorio mínimo viable (actual + corto plazo)

| ID | Entrega | Criterio de hecho |
|----|---------|-------------------|
| A1 | Oracle + GLPI en Docker | `docker compose up` estable en al menos un perfil de Mac objetivo |
| A2 | APEX usable | Login workspace y app demo esqueleto importable |
| A3 | Variables documentadas | `infra/.env.example` alineado con guías de instalación |
| A4 | MCP en modo stub | Servidores arrancan y responden con contratos documentados |

## Fase B — ORDS y publicación

| ID | Entrega | Criterio de hecho |
|----|---------|-------------------|
| B1 | ORDS configurado | Pool a PDB y al menos un módulo REST de prueba |
| B2 | Proxy opcional | Hostnames locales documentados y reproducibles |
| B3 | Tools MCP ORDS | `ords_list_modules` / `ords_test_module` con implementación real o proxy a scripts |

## Fase C — GitLab productivo (institucional)

| ID | Entrega | Criterio de hecho |
|----|---------|-------------------|
| C1 | Instancia GitLab definida | SaaS o CE con políticas de seguridad |
| C2 | Runner hardened | Tags, límites, sin socket Docker abierto en runners compartidos |
| C3 | Protected branches | `main`/`develop` con MR obligatorio y aprobadores |

## Fase D — Automatización APEX

| ID | Entrega | Criterio de hecho |
|----|---------|-------------------|
| D1 | Export split en CI | Job `export_apex` genera artefactos versionables |
| D2 | Validación estática | Linters SQL/PLSQL o validaciones mínimas en `validate` |
| D3 | Despliegue a DEV automático | Tras merge a `develop` con smoke test |

## Fase E — Gobernanza y GLPI

| ID | Entrega | Criterio de hecho |
|----|---------|-------------------|
| E1 | Plantillas de ticket | Tipos alineados a feature/bugfix/hotfix/release |
| E2 | MCP GLPI productivo | Tools críticas implementadas con auditoría |
| E3 | Enlace cambio ↔ despliegue | Procedimiento de control de cambios documentado |

## Fase F — Branding y UX institucional

| ID | Entrega | Criterio de hecho |
|----|---------|-------------------|
| F1 | Tema APEX | `branding/apex-theme/` aplicado a app piloto |
| F2 | UI kit consumido | CSS/variables desde `branding/colors.json` |

## Dependencias críticas

- Licenciamiento Oracle y política de imágenes Docker corporativas.
- Capacidad hardware para GitLab CE local vs decisión SaaS.
- Tiempo del equipo para sustituir stubs MCP por integraciones reales.

## Referencias

- [00-arquitectura-inicial.md](00-arquitectura-inicial.md)
- [99-resumen-iteracion-y-siguientes-pasos.md](99-resumen-iteracion-y-siguientes-pasos.md)
