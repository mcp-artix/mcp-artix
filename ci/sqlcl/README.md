# SQLcl en CI

El archivo [../Dockerfile.sqlcl](../Dockerfile.sqlcl) es una **plantilla** sin SQLcl real: la institución debe proporcionar una imagen con **SQLcl** (y licencia Oracle adecuada) o ejecutar el job en un Runner que ya tenga SQLcl instalado.

Pasos típicos:

1. Crear imagen interna `registry.../sqlcl-ci` con SQLcl + Java.
2. En GitLab CI Variables: `ORACLE_USER`, `ORACLE_PASSWORD`, cadena de conexión (protegidas y enmascaradas).
3. Sustituir el job `export_apex` en [.gitlab-ci.yml](../../.gitlab-ci.yml) para usar esa imagen y ejecutar `sql` / `apex export`.

Referencia: [../../docs/instalacion/03-sqlcl-export-import.md](../../docs/instalacion/03-sqlcl-export-import.md).
