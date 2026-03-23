#!/usr/bin/env bash
# Ejemplo: export split de una aplicación APEX con SQLcl (laboratorio).
# Requisitos: SQLcl en PATH, variables ORACLE_LAB_USER y ORACLE_LAB_PASSWORD en el entorno.
# Uso: ORACLE_LAB_USER=app ORACLE_LAB_PASSWORD=*** bash scripts/sqlcl/export-app-split.sh 100
set -euo pipefail
APP_ID="${1:?Indique application id, ej. 100}"
echo "STUB operativo: conectar con sql y ejecutar:"
echo "  apex export -applicationid ${APP_ID} -split -skipExportDate -overwrite"
echo "Documentación: docs/instalacion/03-sqlcl-export-import.md"
