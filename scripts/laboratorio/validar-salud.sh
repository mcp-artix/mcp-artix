#!/usr/bin/env bash
# Verificación de salud del laboratorio mínimo (Sprint 1).
# Uso:
#   bash scripts/laboratorio/validar-salud.sh
#   bash scripts/laboratorio/validar-salud.sh --con-mcp-compose
#   bash scripts/laboratorio/validar-salud.sh --con-mcp-build

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
INFRA_DIR="$ROOT/infra"
ENV_FILE="$INFRA_DIR/.env"
VERIFICAR_MCP_COMPOSE="false"
VERIFICAR_MCP_BUILD="false"
FALLOS=0

log() {
  printf '[lab-check] %s\n' "$1"
}

ok() {
  printf '[lab-check][OK] %s\n' "$1"
}

warn() {
  printf '[lab-check][WARN] %s\n' "$1"
}

fail() {
  printf '[lab-check][FAIL] %s\n' "$1"
  FALLOS=$((FALLOS + 1))
}

uso() {
  cat <<'EOF'
Uso:
  bash scripts/laboratorio/validar-salud.sh [opciones]

Opciones:
  --con-mcp-compose  Verifica también estado de mcp-oracle-apex y mcp-glpi en Docker Compose.
  --con-mcp-build    Ejecuta compilación local de mcp/oracle-apex y mcp/glpi (requiere Node.js + npm).
  --help             Muestra esta ayuda.
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --con-mcp-compose)
      VERIFICAR_MCP_COMPOSE="true"
      shift
      ;;
    --con-mcp-build)
      VERIFICAR_MCP_BUILD="true"
      shift
      ;;
    --help|-h)
      uso
      exit 0
      ;;
    *)
      fail "Opción no reconocida: $1"
      uso
      exit 1
      ;;
  esac
done

if ! command -v docker >/dev/null 2>&1; then
  fail "Docker no está disponible en PATH."
  exit 1
fi

if ! docker compose version >/dev/null 2>&1; then
  fail "No se pudo ejecutar 'docker compose'. Verifique Docker Desktop."
  exit 1
fi

if [[ ! -f "$ENV_FILE" ]]; then
  fail "No existe infra/.env. Ejecute primero: bash scripts/init-lab.sh"
  exit 1
fi

leer_env() {
  local clave="$1"
  local por_defecto="$2"
  local valor
  valor="$(grep -E "^${clave}=" "$ENV_FILE" | tail -n 1 | cut -d'=' -f2- || true)"
  valor="${valor//$'\r'/}"
  valor="${valor%\"}"
  valor="${valor#\"}"
  valor="${valor%\'}"
  valor="${valor#\'}"
  if [[ -z "$valor" ]]; then
    printf '%s' "$por_defecto"
  else
    printf '%s' "$valor"
  fi
}

servicio_compose() {
  local servicio="$1"
  (
    cd "$INFRA_DIR"
    docker compose ps -q "$servicio"
  )
}

verificar_servicio() {
  local servicio="$1"
  local requiere_health="$2"
  local cid
  local estado
  local health

  cid="$(servicio_compose "$servicio" | tr -d '\r')"
  if [[ -z "$cid" ]]; then
    fail "Servicio '$servicio' no está creado/activo en Docker Compose."
    return
  fi

  estado="$(docker inspect --format '{{.State.Status}}' "$cid" 2>/dev/null || true)"
  health="$(docker inspect --format '{{if .State.Health}}{{.State.Health.Status}}{{else}}sin-healthcheck{{end}}' "$cid" 2>/dev/null || true)"

  if [[ "$estado" != "running" ]]; then
    fail "Servicio '$servicio' no está en ejecución (estado actual: ${estado:-desconocido})."
    return
  fi

  if [[ "$requiere_health" == "true" && "$health" != "healthy" ]]; then
    fail "Servicio '$servicio' ejecutando pero healthcheck no está en 'healthy' (actual: ${health:-desconocido})."
    return
  fi

  ok "Servicio '$servicio' en ejecución (health: ${health:-n/d})."
}

verificar_puerto() {
  local host="$1"
  local puerto="$2"
  local nombre="$3"
  if command -v nc >/dev/null 2>&1; then
    if nc -z "$host" "$puerto" >/dev/null 2>&1; then
      ok "$nombre accesible en $host:$puerto."
    else
      fail "$nombre no responde en $host:$puerto."
    fi
  else
    warn "No se encontró 'nc'; se omite verificación de puerto para $nombre."
  fi
}

verificar_http() {
  local url="$1"
  local nombre="$2"
  if ! command -v curl >/dev/null 2>&1; then
    warn "No se encontró 'curl'; se omite verificación HTTP para $nombre."
    return
  fi

  local codigo
  codigo="$(curl -k -sS -o /dev/null -w "%{http_code}" "$url" || true)"
  if [[ "$codigo" =~ ^2[0-9][0-9]$ || "$codigo" =~ ^3[0-9][0-9]$ ]]; then
    ok "$nombre responde por HTTP ($codigo) en $url."
  else
    fail "$nombre no respondió con código 2xx/3xx en $url (código: ${codigo:-sin_respuesta})."
  fi
}

validar_build_mcp() {
  local nombre="$1"
  local ruta="$2"
  if [[ ! -d "$ruta" ]]; then
    fail "No existe ruta MCP: $ruta"
    return
  fi
  if [[ ! -f "$ruta/package.json" ]]; then
    fail "No se encontró package.json en $ruta"
    return
  fi

  (
    cd "$ruta"
    npm run build >/dev/null
  ) && ok "Compilación MCP exitosa: $nombre" || fail "Falló compilación MCP: $nombre"
}

ORACLE_PORT="$(leer_env "ORACLE_PORT" "1521")"
GLPI_HTTP_PORT="$(leer_env "GLPI_HTTP_PORT" "8081")"

log "Verificando servicios base (oracle, mariadb, glpi)."
verificar_servicio "oracle" "true"
verificar_servicio "mariadb" "true"
verificar_servicio "glpi" "false"

verificar_puerto "127.0.0.1" "$ORACLE_PORT" "Oracle listener"
verificar_http "http://127.0.0.1:${GLPI_HTTP_PORT}/" "GLPI"

if [[ "$VERIFICAR_MCP_COMPOSE" == "true" ]]; then
  log "Verificando servicios MCP en Compose."
  verificar_servicio "mcp-oracle-apex" "false"
  verificar_servicio "mcp-glpi" "false"
fi

if [[ "$VERIFICAR_MCP_BUILD" == "true" ]]; then
  if ! command -v node >/dev/null 2>&1; then
    fail "Node.js no está disponible; no se puede validar build MCP."
  elif ! command -v npm >/dev/null 2>&1; then
    fail "npm no está disponible; no se puede validar build MCP."
  else
    log "Validando compilación local MCP."
    validar_build_mcp "oracle-apex" "$ROOT/mcp/oracle-apex"
    validar_build_mcp "glpi" "$ROOT/mcp/glpi"
  fi
fi

if [[ "$FALLOS" -eq 0 ]]; then
  ok "Verificación completada sin fallos."
  exit 0
fi

printf '[lab-check][FAIL] Verificación completada con %s fallo(s). Revise logs y configuración.\n' "$FALLOS"
exit 1
