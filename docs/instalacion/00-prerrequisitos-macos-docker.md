# Prerrequisitos: macOS y Docker Desktop

## Objetivo

Preparar el equipo para ejecutar el laboratorio definido en [../11-guia-instalacion-laboratorio.md](../11-guia-instalacion-laboratorio.md).

## Software

- **Docker Desktop** para Mac (Apple Silicon o Intel), con el motor en ejecución.
- **Git** para clonar y versionar el repositorio `empornac-ai-dev-platform`.
- **Node.js 20 LTS** (recomendado) si ejecutará los MCP en el host en lugar del contenedor.

## Recursos

- **RAM:** 8 GB mínimo para solo Oracle o solo GLPI; **16 GB o más** si se activan GitLab CE, Oracle y GLPI simultáneamente.
- **Disco:** varios GB para imágenes y volúmenes (Oracle y GitLab crecen con el uso).

## Configuración de Docker Desktop

- Asignar CPUs y memoria acordes (Settings → Resources).
- **VirtioFS** o opciones de rendimiento de volúmenes según versión de Docker (mejorar I/O en bind mounts).
- Si usa **Rosetta** / emulación para imágenes `linux/amd64` en Apple Silicon, espere arranques más lentos.

## Redes y puertos

El archivo [../../infra/.env.example](../../infra/.env.example) define puertos por variables. Antes de `docker compose up`, verifique que **no haya conflictos** con servicios locales (por ejemplo otro Oracle, MySQL o servidor web en 80/8080).

## Volúmenes

Los datos persistentes del laboratorio viven en **volúmenes nombrados** de Docker (ver `infra/docker-compose.yml`). Para **resetear** el laboratorio: detener contenedores y eliminar volúmenes consciente de que **se pierden datos**.

## Problemas frecuentes

| Síntoma | Acción |
|---------|--------|
| `no space left on device` | Limpiar imágenes y volúmenes no usados en Docker Desktop |
| Contenedor sale inmediatamente | `docker compose logs <servicio>` |
| Imagen wrong architecture | Forzar plataforma en override (ver comentarios en compose) o usar imagen con soporte arm64 |
| GitLab inutilizable en Mac | Usar perfil sin GitLab y conectar a **GitLab SaaS**; ver [04-gitlab-ce.md](04-gitlab-ce.md) |

## Seguridad

No ejecute el compose **expuesto a redes no confiables** con contraseñas de ejemplo. El laboratorio es para **demostración interna**.
