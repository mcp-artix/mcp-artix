# GitLab CE (perfil `gitlab` — opcional)

## Preferencia del proyecto

Si existe **GitLab en un servidor dedicado** en la red, **no** use este perfil: use [../../docs/instalacion/04-gitlab-servidor-dedicado.md](../../docs/instalacion/04-gitlab-servidor-dedicado.md) y registre el Runner contra esa URL.

## Advertencia

GitLab CE consume **muchos** recursos. En **Apple Silicon**, suele requerir `platform: linux/amd64` (emulación). En Macs con **16 GB RAM**, suele ser preferible **servidor dedicado** o **GitLab.com**.

## Arranque

```bash
cd ..
docker compose --profile gitlab up -d gitlab
```

## Variables

`GITLAB_HTTP_PORT`, `GITLAB_SSH_PORT`, `GITLAB_OMNIBUS_CONFIG_EXTERNAL_URL` en [../.env.example](../.env.example).

## Primer acceso

Siga la documentación oficial de GitLab para Docker: obtención de contraseña `root` inicial y hardening.

## Documentación ampliada

[../../docs/instalacion/04-gitlab-ce.md](../../docs/instalacion/04-gitlab-ce.md)
