# Infraestructura Docker (laboratorio)

## Documentación detallada

Siga primero [../docs/11-guia-instalacion-laboratorio.md](../docs/11-guia-instalacion-laboratorio.md) y los ficheros en [../docs/instalacion/](../docs/instalacion/).

## Inicio rápido

```bash
cd infra
cp .env.example .env
# Editar .env — valores solo de laboratorio

docker compose up -d oracle mariadb glpi
```

Atajo recomendado (desde la raíz del repo):

```bash
bash scripts/laboratorio/start-minimo.sh
bash scripts/laboratorio/validar-salud.sh
```

## GitLab (recomendación)

**Modo habitual:** conectar el repositorio y los Runners a un **GitLab autohospedado en servidor** de la red (HTTPS). Ver [../docs/instalacion/04-gitlab-servidor-dedicado.md](../docs/instalacion/04-gitlab-servidor-dedicado.md). Variables de referencia: `GITLAB_SERVER_URL` y `GITLAB_REMOTE_SSH_HOST` en [.env.example](.env.example).

**No** es obligatorio levantar el servicio `gitlab` del compose en el Mac.

## Perfiles Compose

| Perfil | Servicios | Notas |
|--------|-----------|--------|
| *(ninguno)* | `oracle`, `mariadb`, `glpi` | Núcleo demostrativo |
| `gitlab` | `gitlab` | Solo si **no** hay servidor GitLab; alto consumo — ver [gitlab/README.md](gitlab/README.md) |
| `runner` | `gitlab-runner` | Registro contra `GITLAB_SERVER_URL` (servidor dedicado) u otro GitLab |
| `mcp` | `mcp-oracle-apex`, `mcp-glpi` | Opcional; muchos equipos ejecutan MCP en el host |

```bash
docker compose --profile gitlab up -d
docker compose --profile runner up -d gitlab-runner
docker compose --profile mcp build
```

Si usa perfil `mcp` dentro de Docker, configure en `infra/.env`:

- `ORACLE_CONNECTION_MCP` (con host `oracle`).
- `GLPI_API_URL_MCP` (por defecto `http://glpi`).

## Override local (Mac)

Copie [docker-compose.override.example.yml](docker-compose.override.example.yml) a `docker-compose.override.yml` para límites de memoria o `platform: linux/amd64`. **No** versionar el override si contiene datos sensibles.

## Subcarpetas

- [oracle/](oracle/README.md) — variables y notas Oracle
- [ords/](ords/README.md) — ORDS (plantilla)
- [gitlab/](gitlab/README.md)
- [gitlab-runner/](gitlab-runner/README.md)
- [glpi/](glpi/README.md)
- [reverse-proxy/](reverse-proxy/README.md)
- [volumes/](volumes/README.md)

## ORDS

No hay servicio ORDS listo en el compose base. Opciones documentadas en [../docs/instalacion/02-apex-y-ords.md](../docs/instalacion/02-apex-y-ords.md).
