# Oracle Database (contenedor de laboratorio)

## Imagen

Por defecto: `gvenzl/oracle-free:latest` en [../docker-compose.yml](../docker-compose.yml).

Consulte [../../docs/instalacion/01-oracle-database-laboratorio.md](../../docs/instalacion/01-oracle-database-laboratorio.md) para arranque, PDB y alternativas **ARM64**.

## Variables

Definidas en [../.env.example](../.env.example): `ORACLE_PASSWORD`, `ORACLE_DATABASE`, `ORACLE_PORT`, `ORACLE_HTTP_PORT`.

## Datos

Volumen Docker: `oracle_data`. Backup institucional antes de actualizar imagen.

## APEX

APEX suele estar disponible según la etiqueta de imagen; validar en documentación de **gvenzl/oracle-free** para su tag concreto.
