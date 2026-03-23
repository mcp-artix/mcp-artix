# GitLab CE en Docker (laboratorio) — alternativa local

## Objetivo

Opcionalmente ejecutar **GitLab Community Edition** en **Docker** (perfil `gitlab` del compose) para quien **no** disponga aún de un servidor GitLab en red.

## Modo recomendado para equipos con servidor dedicado

Si su organización usa **GitLab autohospedado en un servidor** (LAN/VPN), **no** necesita este contenedor: siga [04-gitlab-servidor-dedicado.md](04-gitlab-servidor-dedicado.md) y registre el **Runner** contra esa URL.

## Advertencia de recursos

GitLab CE es **pesado** (CPU, RAM, disco). En MacBook con **16 GB de RAM** suele ser **incómodo** o inviable junto a Oracle y GLPI; en Apple Silicon a menudo implica emulación `linux/amd64`.

## Otras alternativas

- **GitLab.com (SaaS)** — mismo [.gitlab-ci.yml](../../.gitlab-ci.yml); Runner local o compartido.
- **Servidor dedicado en red** — ver [04-gitlab-servidor-dedicado.md](04-gitlab-servidor-dedicado.md).

## Arranque con Compose (perfil `gitlab`)

En [../../infra/docker-compose.yml](../../infra/docker-compose.yml) el servicio `gitlab` está bajo el perfil `gitlab`.

```bash
cd infra
docker compose --profile gitlab up -d gitlab
```

## Variables

Ver `GITLAB_*` en [../../infra/.env.example](../../infra/.env.example). El primer arranque puede tardar **10–20+ minutos**.

## Primer acceso

1. Obtener contraseña inicial de `root` según método oficial GitLab para instalación Docker (lectura de `/etc/gitlab/initial_root_password` **dentro** del contenedor, procedimiento sujeto a versión de GitLab).
2. Cambiar contraseña y desactivar registro abierto en entornos reales.
3. Crear proyecto importando este repositorio o push desde local.

## SMTP / LDAP

Configuración típica de producción; para laboratorio puede omitirse o usarse un servidor de correo de pruebas **no productivo**.

## Documentación cruzada

- [../../infra/gitlab/README.md](../../infra/gitlab/README.md)
- [05-gitlab-runner.md](05-gitlab-runner.md)
