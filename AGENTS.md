# Guía para agentes de IA (Codex, Cursor, etc.)

## Propósito del repositorio

`empornac-ai-dev-platform` concentra la **plataforma demostrativa** de desarrollo asistido por IA: Docker (Oracle, GLPI, GitLab opcional), APEX/ORDS, CI/CD GitLab, integración metodológica con **GLPI** y dos **servidores MCP**. El objetivo es **trazabilidad**, **seguridad** y **separación de entornos**, no reemplazar políticas institucionales.

## Idioma

- **Todo** lo que se añada al repo (documentación, comentarios, nombres descriptivos de entregables en Markdown, mensajes de ejemplo) debe estar en **español**.
- Código (identificadores TypeScript/SQL) puede seguir convención en inglés si ya existe en el módulo; nuevos módulos deben priorizar claridad para el equipo hispanohablante en comentarios y documentación.

## Estructura del proyecto (mapa mental)

- `docs/` — Arquitectura, flujos, riesgos, MCP, **instalación** (`docs/11`, `docs/instalacion/`).
- `infra/` — Docker Compose, `.env.example`, README por componente.
- `environments/` — DEV, QA, PROD: variables de ejemplo y propósito.
- `database/`, `apex/` — Artefactos Oracle/APEX versionables.
- `mcp/oracle-apex`, `mcp/glpi` — Servidores MCP TypeScript.
- `ci/`, `.gitlab-ci.yml` — Pipelines y scripts de validación.
- `templates/` — Plantillas GitLab y prompts reutilizables.
- `branding/` — Lineamientos y recursos visuales.

## Principios de seguridad

- **Nunca** commitear secretos, contraseñas productivas, tokens GLPI, claves SSH ni `.env` reales.
- Usar solo [infra/.env.example](infra/.env.example) y `*.env.example` en MCP como referencia.
- Si se detecta un secreto filtrado: revocar credencial en el sistema origen, no solo borrar del historial (procedimiento institucional).

## Separación DEV / QA / PROD

- Respetar convenciones en `environments/<entorno>/`.
- Los pipelines **no** deben desplegar a **PROD** sin **job manual** y política de aprobación (ver [docs/05-estrategia-ci-cd.md](docs/05-estrategia-ci-cd.md)).
- No mezclar datos de un entorno en otro sin procedimiento documentado.

## Convención de ramas

Ver [docs/04-estandares-de-ramas-y-commits.md](docs/04-estandares-de-ramas-y-commits.md): `main`, `develop`, `feature/*`, `bugfix/*`, `release/*`, `hotfix/*`.

## Convención de commits

Formato con ticket GLPI: `tipo(ámbito): GLPI-<id> descripción`.

## Normas para documentación

- Actualizar **docs** y **README de infra** si cambia comportamiento de Compose o variables.
- Las guías de instalación viven en `docs/instalacion/`; evitar duplicar pasos contradictorios en otros sitios.
- Marcar explícitamente **plantilla**, **stub** o **no verificado** cuando aplique.

## Variables de entorno

- Solo ejemplos en Git; valores reales en `.env` local o CI Variables.
- Documentar cada variable nueva en `.env.example` con comentario en español.

## GitLab

- Por defecto se asume **GitLab autohospedado en servidor** en la red (no el contenedor `gitlab` del compose). Ver [docs/instalacion/04-gitlab-servidor-dedicado.md](docs/instalacion/04-gitlab-servidor-dedicado.md).

## Despliegues

- Seguir [docs/03-flujo-dev-qa-prod.md](docs/03-flujo-dev-qa-prod.md).
- Antes de automatizar un nuevo despliegue: MR + revisión + actualización de riesgos si cambia superficie de ataque.

## MCP

- Código en TypeScript; herramientas nuevas: tipar entradas/salidas, documentar en README del MCP y en `docs/06` o `docs/07`.
- No afirmar que una tool está “productiva” si sigue en **stub**.

## Prohibiciones

- No eliminar documentación útil sin integrar o archivar con justificación en el MR.
- No usar datos personales reales en seeds o demos.
- No exponer el laboratorio a Internet público con credenciales por defecto.

## Estilo de trabajo esperado

- Cambios **pequeños** y **enfocados**; una tarea lógica por MR cuando sea posible.
- Probar localmente lo que sea razonable (compose, build MCP) antes de proponer merge.

## Regla de cambios grandes

Antes de refactorizar arquitectura, mover muchos servicios en Compose o rediseñar pipelines: **documentar el plan** en un MD bajo `docs/` o en el cuerpo del MR con sección “Plan”, enlazando riesgos y rollback.

## Instalación y arranque

Los agentes deben orientar a los humanos según [docs/11-guia-instalacion-laboratorio.md](docs/11-guia-instalacion-laboratorio.md), sin inventar credenciales ni atajos inseguros.
