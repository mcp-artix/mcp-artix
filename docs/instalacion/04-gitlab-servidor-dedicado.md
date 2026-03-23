# GitLab en servidor dedicado (red interna) — modo recomendado

## Objetivo

Documentar cómo este repositorio se conecta a una instancia **GitLab** (típicamente **GitLab CE** u **EE**) **autohospedada en un servidor de la organización**, accesible por HTTPS en la red (LAN/VPN), **sin** ejecutar GitLab en el Mac ni en el `docker-compose` del laboratorio.

Es el encaje natural para equipos con **GitLab en máquina dedicada** y desarrolladores en portátiles con recursos limitados.

> Si aún no dispone de acceso institucional, use temporalmente [10-github-modo-puente.md](10-github-modo-puente.md).

## Qué necesita el equipo

| Elemento | Notas |
|----------|--------|
| URL de GitLab | Por ejemplo `https://gitlab.empresa.corp` (HTTPS con certificado válido en la red) |
| Proyecto | Este repo importado o creado como proyecto vacío y `git remote` apuntando al servidor |
| Runner(s) | Pueden estar en el **servidor GitLab**, en **otros servidores** o en el **Mac del desarrollador** (Docker) |
| Acceso de red | El Mac debe resolver DNS y alcanzar la URL por **VPN** si aplica |

## Configuración en tu máquina (desarrollador)

1. **Clonar** desde la URL que da GitLab (HTTPS o SSH):

   ```bash
   git clone https://gitlab.empresa.corp/grupo/empornac-ai-dev-platform.git
   cd empornac-ai-dev-platform
   ```

2. **SSH (opcional):** añadir la clave pública en GitLab (**Preferences → SSH Keys**) y usar remote SSH:

   ```bash
   git remote set-url origin git@gitlab.empresa.corp:grupo/empornac-ai-dev-platform.git
   ```

3. **Variables de referencia local** (opcional): copie [../../infra/.env.example](../../infra/.env.example) y complete `GITLAB_SERVER_URL` y `GITLAB_REMOTE_SSH_HOST` **solo** para documentación en su equipo o scripts; **no** commitear valores reales si contienen datos sensibles.

## CI/CD (`.gitlab-ci.yml`)

El archivo [.gitlab-ci.yml](../../.gitlab-ci.yml) es **portable**: la misma definición se ejecuta en GitLab.com, GitLab CE en servidor o EE, siempre que:

- Los **Runners** tengan las etiquetas esperadas (p. ej. `docker`; ver `default.tags` en el YAML).
- Las **variables** de CI (Oracle, despliegues, etc.) estén definidas en **Settings → CI/CD → Variables** del proyecto o del grupo.

No hace falta cambiar el YAML solo por tener GitLab en un servidor dedicado.

## GitLab Runner contra el servidor dedicado

El Runner **no** tiene que estar en el mismo servidor que GitLab; solo debe poder **registrarse** y **hablar** con la API de GitLab.

1. En el proyecto del servidor: **Settings → CI/CD → Runners** → crear runner y copiar **URL** y **token** (el URL será el de su GitLab interno, p. ej. `https://gitlab.empresa.corp/`).

2. Registrar el runner (en el Mac con Docker, o en un contenedor `gitlab-runner`):

   ```bash
   gitlab-runner register \
     --url "https://gitlab.empresa.corp/" \
     --token "glrt-REEMPLAZAR_TOKEN" \
     --executor docker \
     --docker-image alpine:3.19 \
     --description "runner-mac-desarrollo" \
     --tag-list "docker,apex"
   ```

3. Detalle adicional: [05-gitlab-runner.md](05-gitlab-runner.md).

## Seguridad y certificados

- Preferir **HTTPS** con certificado firmado por la **CA interna** o conocida por los clientes.
- Si en laboratorio usan certificado autofirmado, configure Git y el Runner para confiar en la CA o use flags solo en entorno de prueba (no productivo).

## Relación con Docker del laboratorio

En este modo **no** levanta el servicio `gitlab` del [../../infra/docker-compose.yml](../../infra/docker-compose.yml). El compose sigue sirviendo para **Oracle**, **GLPI**, **MCP**, etc.

El perfil `gitlab` del compose queda como **alternativa** (ver [04-gitlab-ce.md](04-gitlab-ce.md)) para quien no tenga servidor aún.

## Checklist rápido

- [ ] `git remote -v` apunta al servidor dedicado  
- [ ] Acceso web a GitLab desde el navegador (misma red/VPN)  
- [ ] Al menos un Runner **activo** y con tags alineados al pipeline  
- [ ] Variables de CI creadas en el proyecto (sin pegar secretos en el repo)
