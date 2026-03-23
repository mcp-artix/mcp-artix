#!/usr/bin/env bash
# Arranque del laboratorio mínimo (Sprint 1).
# Uso:
#   bash scripts/laboratorio/start-minimo.sh
#   bash scripts/laboratorio/start-minimo.sh --con-mcp-compose
#   bash scripts/laboratorio/start-minimo.sh --con-mcp-compose --validar

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
INFRA_DIR="$ROOT/infra"
ENV_FILE="$INFRA_DIR/.env"
ENV_EXAMPLE="$INFRA_DIR/.env.example"
VALIDAR_AL_FINAL="false"
CON_MCP_COMPOSE="false"

log() {
  printf '[lab-start] %s\n' "$1"
}

error() {
  printf '[lab-start][ERROR] %s\n' "$1" >&2
}

uso() {
  cat <<'EOF'
Uso:
  bash scripts/laboratorio/start-minimo.sh [opciones]

Opciones:
  --con-mcp-compose  Levanta también mcp-oracle-apex y mcp-glpi (perfil mcp).
  --validar          Ejecuta validar-salud.sh al finalizar el arranque.
  --help             Muestra esta ayuda.
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --con-mcp-compose)
      CON_MCP_COMPOSE="true"
      shift
      ;;
    --validar)
      VALIDAR_AL_FINAL="true"
      shift
      ;;
    --help|-h)
      uso
      exit 0
      ;;
    *)
      error "Opción no reconocida: $1"
      uso
      exit 1
      ;;
  esac
done

if ! command -v docker >/dev/null 2>&1; then
  error "Docker no está disponible en PATH."
  exit 1
fi

if ! docker compose version >/dev/null 2>&1; then
  error "No se pudo ejecutar 'docker compose'. Verifique Docker Desktop."
  exit 1
fi

if [[ ! -f "$ENV_FILE" ]]; then
  if [[ ! -f "$ENV_EXAMPLE" ]]; then
    error "No existe $ENV_EXAMPLE."
    exit 1
  fi
  cp "$ENV_EXAMPLE" "$ENV_FILE"
  log "Se creó infra/.env desde infra/.env.example. Revise placeholders antes de uso extendido."
else
  log "Se usará infra/.env existente."
fi

log "Levantando servicios base: oracle, mariadb, glpi"
(
  cd "$INFRA_DIR"
  docker compose up -d oracle mariadb glpi
)

if [[ "$CON_MCP_COMPOSE" == "true" ]]; then
  log "Levantando perfil mcp: mcp-oracle-apex, mcp-glpi"
  (
    cd "$INFRA_DIR"
    docker compose --profile mcp up -d mcp-oracle-apex mcp-glpi
  )
fi

log "Arranque solicitado. Siguiente paso recomendado:"
if [[ "$CON_MCP_COMPOSE" == "true" ]]; then
  log "  bash scripts/laboratorio/validar-salud.sh --con-mcp-compose"
else
  log "  bash scripts/laboratorio/validar-salud.sh"
fi

if [[ "$VALIDAR_AL_FINAL" == "true" ]]; then
  if [[ "$CON_MCP_COMPOSE" == "true" ]]; then
    bash "$ROOT/scripts/laboratorio/validar-salud.sh" --con-mcp-compose
  else
    bash "$ROOT/scripts/laboratorio/validar-salud.sh"
  fi
fi
