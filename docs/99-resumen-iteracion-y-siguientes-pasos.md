# Resumen de la iteración inicial y siguientes pasos

## Qué se construyó (visión ejecutiva)

- **Repositorio estructurado** con carpetas `docs`, `infra`, `environments`, `database`, `apex`, `mcp`, `glpi`, `branding`, `ci`, `scripts`, `templates`.
- **Documentación en español**: arquitectura, flujos DEV/QA/PROD, ramas/commits, CI/CD, diseño de ambos MCP, demo, riesgos, branding, **guía maestra de instalación** (`docs/11`) y **guías por componente** (`docs/instalacion/`).
- **Infraestructura como plantilla**: `infra/docker-compose.yml`, `.env.example`, README por servicio.
- **AGENTS.md** para trabajo futuro con agentes.
- **GitLab CI** inicial con stages y **gates manuales** en QA/PROD.
- **MCP** Oracle/APEX y GLPI en TypeScript con tools **stub** documentadas.
- **Branding** con `colors.json`, tipografía, reglas UI y carpetas para assets.
- **App demo** documentada: “Sistema de Gestión de Requerimientos Internos”.
- **Prompts reutilizables** en `templates/prompts/`.

## Siguientes pasos verificables

1. **Validar en hardware real:** `docker compose up` con perfil mínimo (Oracle + GLPI) en su Mac.
2. **Completar ORDS** según política Oracle (host o contenedor corporativo).
3. **Conectar** el proyecto al **GitLab del servidor dedicado** ([instalacion/04-gitlab-servidor-dedicado.md](instalacion/04-gitlab-servidor-dedicado.md)); script de comprobación: [../scripts/gitlab/preflight-gitlab.sh](../scripts/gitlab/preflight-gitlab.sh). **Registrar Runner** y definir imagen CI con SQLcl ([../ci/sqlcl/README.md](../ci/sqlcl/README.md)).
4. **MCP:** `git_diff_repo` y `glpi_get_ticket` ya tienen implementación base; completar el resto de tools según prioridad.
5. **Importar** DDL de la app demo y crear app APEX **100** (o ID acordado); primer export split en `apex/exports/`.
6. **Sustituir** placeholders de branding por assets oficiales aprobados.
7. **Configurar** GitLab protected environments y aprobadores para `deploy_prod`.

## Riesgos que permanecen

- Si se usa GitLab **solo** en Docker en el Mac: carga y emulación `amd64`; preferir **servidor dedicado** en red.
- Complejidad legal/técnica de imágenes Oracle en registry oficial.
- Seguridad de MCP con SQL y escritura en GLPI: requiere diseño de permisos.

## Documentos de entrada recomendados para nuevos integrantes

1. [11-guia-instalacion-laboratorio.md](11-guia-instalacion-laboratorio.md)
2. [instalacion/04-gitlab-servidor-dedicado.md](instalacion/04-gitlab-servidor-dedicado.md) (si aplica)
3. [AGENTS.md](../AGENTS.md)
4. [03-flujo-dev-qa-prod.md](03-flujo-dev-qa-prod.md)
