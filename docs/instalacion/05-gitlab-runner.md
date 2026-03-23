# GitLab Runner con Docker (macOS)

## Objetivo

Registrar un **GitLab Runner** con executor **docker** para ejecutar los jobs del [.gitlab-ci.yml](../../.gitlab-ci.yml).

## Prerrequisitos

- Una instancia GitLab accesible: **recomendado** [GitLab en servidor dedicado](04-gitlab-servidor-dedicado.md), o GitLab.com, o el contenedor local (perfil `gitlab`).
- Docker Desktop operativo (el Runner usará el socket Docker del host en el modo documentado en compose).

## Crear el Runner en GitLab

1. En el proyecto: **Settings → CI/CD → Runners**.
2. **New project runner**: etiquetas recomendadas para este repo: `docker`, `apex` (ajustar según sus jobs).
3. Copiar el **token de registro** (aparece una sola vez). **No** lo guarde en Git.

## Variables en GitLab (CI/CD)

Configure en **Settings → CI/CD → Variables** (mascaradas y protegidas según política):

- `ORACLE_HOST`, `ORACLE_SERVICE`, `ORACLE_USER`, `ORACLE_PASSWORD` — solo si ejecuta jobs contra Oracle.
- Cualquier token para GLPI si los jobs lo requieren.

## Arranque con Compose (perfil `runner`)

El servicio `gitlab-runner` está en el perfil `runner` y monta `/var/run/docker.sock` (en Mac, Docker Desktop expone el socket al VM Linux).

```bash
cd infra
docker compose --profile runner up -d gitlab-runner
```

Luego **registre** el runner dentro del contenedor (el comando exacto depende de la versión de GitLab Runner; siga la página “Register a runner” de su GitLab). Ejemplo genérico:

```bash
docker exec -it empornac-gitlab-runner gitlab-runner register \
  --url "https://gitlab.example.com/" \
  --token "glrt-REEMPLAZAR_TOKEN_DE_REGISTRO" \
  --executor docker \
  --docker-image alpine:3.19 \
  --description "runner-lab-mac" \
  --tag-list "docker,apex"
```

Sustituya URL y token por los suyos.

## Consideraciones en Mac

- El executor **docker** lanza contenedores **hermanos** del runner; los volúmenes y redes deben ser coherentes con cómo monta el proyecto.
- Si los jobs necesitan acceder a Oracle en el host, use `host.docker.internal` desde contenedores de job (Docker Desktop Mac).

## Seguridad

Un runner con acceso al socket Docker es **muy sensible**. En laboratorio está aceptado; en producción use aislamiento, tokens rotados y runners dedicados.

## Referencia

- [../../infra/gitlab-runner/README.md](../../infra/gitlab-runner/README.md)
