# empornac-ai-dev-platform

Repositorio maestro de la **plataforma demostrativa empresarial** de desarrollo asistido por IA: Oracle (laboratorio), APEX, ORDS, **GitLab** (recomendado en **servidor dedicado** en red), GitLab Runner, GLPI, CI/CD metodológico y dos servidores MCP (Oracle/APEX y GLPI).

**Idioma del proyecto:** todo el contenido mantenido en **español** (documentación, comentarios, plantillas).

## Inicio rápido

1. Revisar requisitos y orden de arranque en [docs/11-guia-instalacion-laboratorio.md](docs/11-guia-instalacion-laboratorio.md).
2. Copiar variables de ejemplo: `cp infra/.env.example infra/.env` y editar **solo placeholders** (no usar credenciales productivas).
3. Desde la carpeta `infra/`: `docker compose up -d` (ajustar perfiles según [infra/README.md](infra/README.md)).
4. Leer [AGENTS.md](AGENTS.md) antes de contribuir con agentes o automatización.

## Estructura principal

| Ruta | Propósito |
|------|-----------|
| [docs/](docs/) | Arquitectura, flujos, CI/CD, MCP, riesgos, branding, **guías de instalación** ([índice](docs/README.md)) |
| [infra/](infra/) | Docker Compose maestro, `.env.example`, README por componente |
| [environments/](environments/) | Variables y documentación **DEV / QA / PROD** |
| [database/](database/) | DDL, migraciones, seeds por entorno |
| [apex/](apex/) | Apps, exports, static files, plantillas |
| [mcp/](mcp/) | Servidores MCP (TypeScript): Oracle/APEX y GLPI |
| [ci/](ci/) | Scripts auxiliares de pipeline |
| [scripts/](scripts/) | Scripts de inicialización y utilidades |
| [templates/](templates/) | Plantillas GitLab, prompts reutilizables |
| [branding/](branding/) | Lineamientos y recursos institucionales (placeholders) |
| [glpi/](glpi/) | Notas de integración metodológica con GLPI |

## Checklist de esta iteración

- [ ] Instalación local seguida según [docs/11-guia-instalacion-laboratorio.md](docs/11-guia-instalacion-laboratorio.md)
- [ ] Variables definidas en `infra/.env` a partir de [infra/.env.example](infra/.env.example)
- [ ] Servicios de laboratorio levantados con los **perfiles** adecuados (ver [infra/README.md](infra/README.md))
- [ ] Checklist Sprint 1 ejecutada: [docs/instalacion/09-laboratorio-minimo-funcional.md](docs/instalacion/09-laboratorio-minimo-funcional.md)
- [ ] Git remoto y CI alineados con GitLab en servidor dedicado: [docs/instalacion/04-gitlab-servidor-dedicado.md](docs/instalacion/04-gitlab-servidor-dedicado.md) (o modo puente temporal: [docs/instalacion/10-github-modo-puente.md](docs/instalacion/10-github-modo-puente.md))
- [ ] GitLab Runner registrado (si aplica) según [docs/instalacion/05-gitlab-runner.md](docs/instalacion/05-gitlab-runner.md)
- [ ] MCP ejecutados según [docs/instalacion/08-servidores-mcp.md](docs/instalacion/08-servidores-mcp.md)
- [ ] Resumen y siguientes pasos: [docs/99-resumen-iteracion-y-siguientes-pasos.md](docs/99-resumen-iteracion-y-siguientes-pasos.md)

## Avisos importantes

- **Laboratorio:** no exponer a Internet con contraseñas por defecto.
- **Apple Silicon:** Oracle y GitLab pueden requerir emulación `linux/amd64` o alternativas documentadas.
- **Producción institucional:** los despliegues reales requieren aprobación, hardening y secretos fuera del repositorio.

## Licencia y uso

Uso demostrativo y de laboratorio. Ajustar licencias Oracle, GitLab y GLPI según política de la organización.
