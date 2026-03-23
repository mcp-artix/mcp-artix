#!/usr/bin/env bash
# Inicializa repositorio Git local y configura origin para GitHub (modo puente).
# Uso:
#   bash scripts/github/bootstrap-local.sh --origin git@github.com:org/repo.git
#   bash scripts/github/bootstrap-local.sh --origin https://github.com/org/repo.git --crear-main

set -euo pipefail

ORIGIN_URL=""
RAMA_INICIAL="develop"
CREAR_MAIN="false"
SIN_COMMIT="false"
MENSAJE_INICIAL="chore(repo): GLPI-0 inicializar repositorio local"

log() {
  printf '[github-bootstrap] %s\n' "$1"
}

fail() {
  printf '[github-bootstrap][ERROR] %s\n' "$1" >&2
  exit 1
}

uso() {
  cat <<'EOF'
Uso:
  bash scripts/github/bootstrap-local.sh [opciones]

Opciones:
  --origin <url>            URL de remote origin (GitHub SSH/HTTPS).
  --rama-inicial <rama>     Rama inicial local. Por defecto: develop.
  --crear-main              Crea rama main local adicional a partir de la rama inicial.
  --sin-commit              Inicializa Git sin commit inicial.
  --mensaje-inicial <msg>   Mensaje del commit inicial.
  --help                    Muestra esta ayuda.
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --origin)
      ORIGIN_URL="${2:-}"
      shift 2
      ;;
    --rama-inicial)
      RAMA_INICIAL="${2:-}"
      shift 2
      ;;
    --crear-main)
      CREAR_MAIN="true"
      shift
      ;;
    --sin-commit)
      SIN_COMMIT="true"
      shift
      ;;
    --mensaje-inicial)
      MENSAJE_INICIAL="${2:-}"
      shift 2
      ;;
    --help|-h)
      uso
      exit 0
      ;;
    *)
      fail "Opción no reconocida: $1"
      ;;
  esac
done

if ! command -v git >/dev/null 2>&1; then
  fail "git no está disponible en PATH."
fi

if [[ -z "$ORIGIN_URL" ]]; then
  fail "Debe indicar --origin <url>."
fi

if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  fail "Ya existe un repositorio Git en este directorio. Use preflight y configure remotes manualmente."
fi

git init -b "$RAMA_INICIAL"
log "Repositorio Git inicializado en rama '$RAMA_INICIAL'."

if [[ "$SIN_COMMIT" != "true" ]]; then
  GIT_USER_NAME="$(git config --get user.name || true)"
  GIT_USER_EMAIL="$(git config --get user.email || true)"
  if [[ -z "$GIT_USER_NAME" || -z "$GIT_USER_EMAIL" ]]; then
    log "No hay user.name/user.email configurados en Git; se omite commit inicial."
    log "Configure identidad y haga commit manual."
  else
    git add .
    git commit -m "$MENSAJE_INICIAL"
    log "Commit inicial creado."
  fi
fi

git remote add origin "$ORIGIN_URL"
log "Remote origin configurado: $ORIGIN_URL"

if [[ "$CREAR_MAIN" == "true" ]]; then
  if git rev-parse --verify HEAD >/dev/null 2>&1; then
    if git show-ref --verify --quiet refs/heads/main; then
      log "Rama main ya existe; no se crea de nuevo."
    else
      git branch main
      log "Rama main creada desde '$RAMA_INICIAL'."
    fi
  else
    log "No hay commit inicial aún; main se creará después del primer commit."
  fi
fi

echo ""
log "Siguientes pasos sugeridos:"
log "  1) bash scripts/github/preflight-github.sh"
log "  2) git push -u origin $RAMA_INICIAL"
if [[ "$CREAR_MAIN" == "true" ]]; then
  log "  3) git push -u origin main"
fi
