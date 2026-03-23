# GLPI en Docker (laboratorio)

## Objetivo

Desplegar **GLPI** con **MariaDB** para gestionar tickets, cambios y problemas enlazados al flujo de desarrollo.

## Componentes

- **mariadb:** almacena datos de GLPI.
- **glpi:** interfaz web y lógica de GLPI.

Definidos en [../../infra/docker-compose.yml](../../infra/docker-compose.yml). Variables en [../../infra/.env.example](../../infra/.env.example).

## Arranque

```bash
cd infra
docker compose up -d mariadb glpi
docker compose logs -f glpi
```

## Primera instalación

Si la base está vacía, GLPI mostrará el **asistente web**:

1. Elegir idioma.
2. Aceptar requisitos.
3. Conectar a la base usando host `mariadb`, usuario y contraseña definidos en `.env` (valores de **laboratorio**).
4. Crear cuenta de administración.

> No use contraseñas productivas. Documente el procedimiento interno para **reset** del laboratorio.

## Versión estable

La imagen Docker concreta se fija en `docker-compose.yml`. Actualícela de forma **consciente** (notas de migración GLPI, backup de BD).

## Integración metodológica

- Cada **feature** o **cambio** debería referenciar un **ticket** GLPI (ID en rama o commit, ver [../04-estandares-de-ramas-y-commits.md](../04-estandares-de-ramas-y-commits.md)).
- **Cambios** y **problemas** ITIL pueden vincularse a despliegues ([../03-flujo-dev-qa-prod.md](../03-flujo-dev-qa-prod.md)).

## API y MCP

Para el MCP GLPI necesitará un **usuario API** o **app token** según versión de GLPI. Configure en `.env` del MCP (ver [08-servidores-mcp.md](08-servidores-mcp.md)), no en texto plano en Git.

## Referencia

- [../../infra/glpi/README.md](../../infra/glpi/README.md)
- [../../glpi/README.md](../../glpi/README.md)
