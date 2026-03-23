#!/usr/bin/env bash
# Inicialización de contexto de laboratorio (sin secretos).
# Uso: desde la raíz del repositorio → bash scripts/init-lab.sh

set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

if [[ ! -f infra/.env ]]; then
  echo "Creando infra/.env desde infra/.env.example (revise valores de laboratorio)."
  cp infra/.env.example infra/.env
else
  echo "infra/.env ya existe; no se sobrescribe."
fi

echo "Siguiente paso recomendado: bash scripts/laboratorio/start-minimo.sh"
echo "Documentación base: docs/11-guia-instalacion-laboratorio.md"
echo "Checklist Sprint 1: docs/instalacion/09-laboratorio-minimo-funcional.md"
