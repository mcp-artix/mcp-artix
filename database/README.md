# Base de datos Oracle (versionado)

## Estructura

| Carpeta | Uso |
|---------|-----|
| `ddl/` | Objetos persistentes (tablas, secuencias, sinónimos) |
| `dml/` | Datos transaccionales versionados (con cuidado) |
| `migrations/` | Scripts ordenados por fecha o número |
| `packages/` | Especificación y cuerpo de paquetes PL/SQL |
| `views/` | Vistas |
| `triggers/` | Triggers |
| `seeds/` | Datos mínimos para laboratorio |
| `common/` | Scripts compartidos por entorno |
| `dev/`, `qa/`, `prod/` | Parches o grants específicos por entorno |

## Entornos

Aplique primero `common/` y `ddl/`, luego seeds, luego scripts bajo `dev|qa|prod` según el despliegue.

## App demo

El diseño funcional está en [../docs/app-demo-requerimientos-internos.md](../docs/app-demo-requerimientos-internos.md). DDL inicial en [ddl/001_req_demo_tablas.sql](ddl/001_req_demo_tablas.sql).
