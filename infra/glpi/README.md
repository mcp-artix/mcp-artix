# GLPI (contenedor)

## Servicios relacionados

- `mariadb` — base de datos
- `glpi` — aplicación web

## Variables

`GLPI_HTTP_PORT`, credenciales MariaDB y nombre de BD en [../.env.example](../.env.example). Variables `GLPI_DB_*` se inyectan en el servicio `glpi` del compose.

## Instalación web

Primera ejecución: asistente en `http://localhost:${GLPI_HTTP_PORT}`.

## Documentación ampliada

[../../docs/instalacion/06-glpi.md](../../docs/instalacion/06-glpi.md)
