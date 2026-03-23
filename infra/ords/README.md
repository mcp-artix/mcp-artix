# ORDS — plantilla

## Estado

**No** se incluye un contenedor ORDS completamente configurado en el `docker-compose.yml` maestro. ORDS requiere JDK, `ords.war`, configuración de pools y, a menudo, políticas de seguridad institucionales.

## Guía

[../../docs/instalacion/02-apex-y-ords.md](../../docs/instalacion/02-apex-y-ords.md)

## Evolución prevista

- Dockerfile corporativo aprobado, o
- Instalación de ORDS en el **host** apuntando a `localhost:1521` hacia el contenedor Oracle.

## Archivos opcionales

Puede añadir aquí scripts o plantillas `ords_params` **sin credenciales**; use referencias a variables de entorno.
