# SQLcl — export e import de APEX

## Objetivo

Documentar el uso de **SQLcl** con los comandos `apex export` para versionar aplicaciones en Git (export **full** y **split**).

## Instalación

Opciones:

1. **Instalación local** en macOS: descargar SQLcl desde el sitio Oracle (según licencia de su organización) y añadirlo al `PATH`.
2. **Contenedor** temporal con SQLcl (si su entorno lo permite) ejecutando el binario contra `host.docker.internal:1521`.

No almacene credenciales en scripts del repositorio.

## Conexión

Ejemplo de cadena (ajustar usuario, host, servicio):

```bash
sql -nolog
# Dentro de SQLcl:
conn LAB_USER/"${ORACLE_LAB_PASSWORD}"@//localhost:1521/FREEPDB1
```

Use variables de entorno en su shell, no literales en archivos versionados.

## Export full (un solo archivo)

Adecuado para backups rápidos o entregas puntuales:

```sql
apex export -applicationid 100 -skipExportDate -overwrite
```

El fichero `.sql` resultante debe guardarse bajo [../../apex/exports/](../../apex/exports/) según la convención del equipo.

## Export split (múltiples archivos)

Recomendado para **revisiones de código** y merges más legibles:

```sql
apex export -applicationid 100 -split -skipExportDate -overwrite
```

Genera un directorio con componentes separados (páginas, shared components, etc.).

## Import

```sql
apex import -file f100.sql
```

Valide siempre en **DEV** antes de promocionar.

## Integración CI

El job `export_apex` del pipeline ([../05-estrategia-ci-cd.md](../05-estrategia-ci-cd.md)) debe usar secretos de GitLab (`ORACLE_*`) y un Runner con SQLcl instalado o imagen corporativa.

## Documentación ampliada

Ver [../../apex/README.md](../../apex/README.md) y [../../database/README.md](../../database/README.md).
