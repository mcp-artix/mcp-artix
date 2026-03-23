# Oracle Database — laboratorio Docker

## Objetivo

Levantar una instancia **Oracle Database** apta para pruebas de APEX y desarrollo, usando la imagen referenciada en [../../infra/oracle/README.md](../../infra/oracle/README.md).

## Imagen por defecto en este repositorio

Se documenta **gvenzl/oracle-free** (imagen comunitaria ampliamente usada en desarrollo). La etiqueta exacta puede ajustarse en `infra/docker-compose.yml`. **Valide** en su Mac (especialmente **ARM64**) que la etiqueta elegida arranca correctamente.

> **Nota:** Las imágenes oficiales en `container-registry.oracle.com` suelen requerir **aceptación de licencia** y autenticación; no están hardcodeadas como obligatorias en este laboratorio.

## Variables de entorno

Definidas en [../../infra/.env.example](../../infra/.env.example), típicamente:

- `ORACLE_PASSWORD` — contraseña del usuario administrativo de la imagen (solo laboratorio).
- `ORACLE_DATABASE` — nombre de la base (según imagen).

Copie el ejemplo:

```bash
cd infra
cp .env.example .env
```

## Arranque

```bash
cd infra
docker compose up -d oracle
docker compose logs -f oracle
```

Espere a que los logs indiquen base lista (el primer arranque puede tardar **varios minutos**).

## Persistencia

El servicio `oracle` usa un volumen Docker nombrado (p. ej. `oracle_data`). Eliminar el volumen implica **reinstalar** desde cero.

## Usuarios y esquemas por entorno (DEV/QA/PROD)

En laboratorio suele usarse **una sola instancia** con:

- Esquemas distintos (`APP_DEV`, `APP_QA`, `APP_PROD`), o
- Un esquema y separación lógica documentada.

Los scripts orientativos están bajo [../../database/](../../database/) y las convenciones en [../../environments/](../../environments/).

## Conexión con SQLcl o cliente

Cadena típica (ajustar host/puerto):

```text
localhost:1521/FREEPDB1
```

Usuario/contraseña según imagen y scripts de creación de usuarios (ver `database/` y README de Oracle).

## Alternativas si Docker falla en ARM

- Oracle en **máquina virtual Linux x86_64** en el mismo Mac o en servidor interno.
- **Oracle Cloud Free Tier** (sujeto a políticas de la organización).
