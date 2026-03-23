# Guía de instalación del laboratorio (índice maestro)

Esta guía orienta la puesta en marcha en **macOS + Docker Desktop** del contenido definido en [infra/README.md](../infra/README.md). Todo valor sensible debe configurarse en `infra/.env` (generado desde [infra/.env.example](../infra/.env.example)), **nunca** en el repositorio.

## Prerrequisitos

- Docker Desktop actualizado, suficiente **RAM** (recomendado **≥ 16 GB** si se activan Oracle + GitLab + GLPI a la vez).
- **Git** y, opcionalmente, **Node.js 20+** para ejecutar los MCP en el host.
- Lectura de [instalacion/00-prerrequisitos-macos-docker.md](instalacion/00-prerrequisitos-macos-docker.md).

## Orden sugerido de lectura y arranque

1. [00-prerrequisitos-macos-docker.md](instalacion/00-prerrequisitos-macos-docker.md)
2. [01-oracle-database-laboratorio.md](instalacion/01-oracle-database-laboratorio.md)
3. [02-apex-y-ords.md](instalacion/02-apex-y-ords.md)
4. [03-sqlcl-export-import.md](instalacion/03-sqlcl-export-import.md)
5. [06-glpi.md](instalacion/06-glpi.md)
6. **GitLab:** [04-gitlab-servidor-dedicado.md](instalacion/04-gitlab-servidor-dedicado.md) (recomendado: instancia en red) y [05-gitlab-runner.md](instalacion/05-gitlab-runner.md). Opcional: [04-gitlab-ce.md](instalacion/04-gitlab-ce.md) solo si ejecuta GitLab en Docker en el Mac.
7. [07-reverse-proxy-opcional.md](instalacion/07-reverse-proxy-opcional.md)
8. [08-servidores-mcp.md](instalacion/08-servidores-mcp.md)
9. [09-laboratorio-minimo-funcional.md](instalacion/09-laboratorio-minimo-funcional.md) (checklist operativa y salud Sprint 1)
10. [10-github-modo-puente.md](instalacion/10-github-modo-puente.md) (si aún no hay acceso a GitLab institucional)

## Comandos base (desde `infra/`)

```bash
cd infra
cp .env.example .env
# Editar .env con valores de laboratorio (placeholders)

# Núcleo: Oracle + GLPI (MariaDB + GLPI)
docker compose up -d oracle mariadb glpi

# Opcional: GitLab CE en Docker (solo si no usa servidor GitLab en red; consume muchos recursos)
# docker compose --profile gitlab up -d

# Opcional: Runner local (registrar contra GITLAB_SERVER_URL del servidor dedicado)
docker compose --profile runner up -d gitlab-runner
```

Para flujo rápido del laboratorio mínimo (desde raíz del repo):

```bash
bash scripts/laboratorio/start-minimo.sh
bash scripts/laboratorio/validar-salud.sh
```

## Verificación rápida

| Servicio | Comprobación orientativa |
|----------|---------------------------|
| Oracle | Puerto `1521` accesible; logs sin error de arranque PDB |
| GLPI | HTTP en puerto configurado (`GLPI_HTTP_PORT`); asistente de instalación si BD vacía |
| GitLab | HTTP `GITLAB_HTTP_PORT`; primer login `root` según doc GitLab |
| MCP | Proceso local `npm run start` en cada carpeta `mcp/*` (ver guía 08) |

Verificación operativa detallada: [instalacion/09-laboratorio-minimo-funcional.md](instalacion/09-laboratorio-minimo-funcional.md).

## Apple Silicon (M1/M2/M3)

Algunas imágenes solo publican `linux/amd64`. Docker puede usar emulación (**más lenta** y con mayor uso de memoria). Si un servicio falla por arquitectura, consulte la guía específica y las alternativas (GitLab SaaS, BD remota, VM x86).

## Checklist

- [ ] `.env` creado y sin secretos productivos
- [ ] Servicios base levantados y saludables
- [ ] APEX accesible según [02-apex-y-ords.md](instalacion/02-apex-y-ords.md)
- [ ] GLPI instalado y enlace con metodología de tickets documentado
- [ ] GitLab/Runner solo si el hardware lo soporta
- [ ] MCP probados en modo desarrollo

## Siguientes pasos metodológicos

- [03-flujo-dev-qa-prod.md](03-flujo-dev-qa-prod.md)
- [05-estrategia-ci-cd.md](05-estrategia-ci-cd.md)
