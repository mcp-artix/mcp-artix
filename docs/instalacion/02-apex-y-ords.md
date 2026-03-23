# Oracle APEX y ORDS en el laboratorio

## Objetivo

Explicar cómo encajan **APEX** y **ORDS** con la base de datos del laboratorio y cómo modelar **DEV / QA / PROD** en URLs y configuración.

## APEX

En muchas imágenes de **Oracle Database Free**, APEX viene **preinstalado** o puede instalarse/actualizarse según la guía de la imagen elegida. Consulte la documentación de la etiqueta concreta de `gvenzl/oracle-free` que use en `docker-compose.yml`.

Pasos generales (laboratorio):

1. Acceder al puerto de administración de APEX según imagen (a menudo vía `https://localhost:<puerto_apex>/ords/...` o puerto dedicado — **ver logs y README del contenedor**).
2. Completar el **Admin Service** la primera vez (contraseñas solo de laboratorio).
3. Crear **workspaces** o convenciones de nombres alineadas a [../../environments/dev/README.md](../../environments/dev/README.md).

## ORDS

**ORDS** (Oracle REST Data Services) publica REST y suele servir APEX detrás de HTTP/HTTPS.

### Estado en este repositorio

El servicio **ORDS en Docker** puede considerarse **plantilla / opcional**: montar ORDS de forma completa implica **WAR**, JDK, `ords.war configure` y pools hacia el PDB. Este repo **no promete** un contenedor ORDS productivo listo sin pasos adicionales institucionales.

Opciones para avanzar:

1. **ORDS en el host** (recomendado para aprendizaje): instalar ORDS según manual Oracle apuntando al contenedor Oracle en `localhost:1521`.
2. **Imagen corporativa** interna que ya empaquete ORDS + configuración.
3. **Perfil Docker futuro** en `infra/docker-compose.yml` cuando exista Dockerfile aprobado.

## Separación DEV / QA / PROD (laboratorio)

| Mecanismo | Ejemplo |
|-----------|---------|
| Esquemas distintos | `REQ_DEV`, `REQ_QA`, `REQ_PROD` |
| Aplicaciones APEX | App ID distintos o copias exportadas por entorno |
| Base URL ORDS | Mapeos `/ords/dev/`, `/ords/qa/`, `/ords/prod/` vía proxy (ver [07-reverse-proxy-opcional.md](07-reverse-proxy-opcional.md)) |

La **promoción** no es solo copiar datos: debe ir acompañada de **export en Git**, **MR** y **pipeline** con aprobación hacia PROD ([05-estrategia-ci-cd.md](../05-estrategia-ci-cd.md)).

## Referencias en el repo

- [../../apex/README.md](../../apex/README.md)
- [../../ords/README.md](../../infra/ords/README.md) (carpeta infra)
