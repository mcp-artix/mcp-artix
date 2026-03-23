#!/usr/bin/env bash
# Valida estructura mínima esperada del repositorio.
set -euo pipefail

ROOT="${1:-.}"
cd "$ROOT"

FALLOS=0

check_dir() {
  local d="$1"
  if [[ -d "$d" ]]; then
    echo "[OK] Carpeta presente: $d"
  else
    echo "[FAIL] Falta carpeta requerida: $d"
    FALLOS=$((FALLOS + 1))
  fi
}

check_file() {
  local f="$1"
  if [[ -f "$f" ]]; then
    echo "[OK] Archivo presente: $f"
  else
    echo "[FAIL] Falta archivo requerido: $f"
    FALLOS=$((FALLOS + 1))
  fi
}

for dir in \
  docs \
  infra \
  environments \
  database \
  apex \
  mcp \
  ci \
  scripts \
  templates \
  branding \
  glpi; do
  check_dir "$dir"
done

for file in \
  AGENTS.md \
  README.md \
  .gitlab-ci.yml \
  infra/docker-compose.yml \
  infra/.env.example \
  ci/scripts/validate-branch-name.sh \
  ci/scripts/validate-commit-message.sh \
  mcp/oracle-apex/src/index.ts \
  mcp/glpi/src/index.ts; do
  check_file "$file"
done

if [[ "$FALLOS" -gt 0 ]]; then
  echo "Estructura inválida: $FALLOS comprobación(es) fallida(s)."
  exit 1
fi

echo "Estructura válida."
