#!/usr/bin/env bash
# Ejecuta validaciones locales equivalentes al pipeline "validate".
# Uso:
#   bash ci/scripts/validate-local.sh
#   bash ci/scripts/validate-local.sh --branch develop
#   bash ci/scripts/validate-local.sh --branch feature/GLPI-10-demo --commit-range a1b2c3..d4e5f6
#   bash ci/scripts/validate-local.sh --skip-mcp-build

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$ROOT"

BRANCH_NAME=""
COMMIT_RANGE=""
SKIP_BRANCH="false"
SKIP_COMMIT="false"
SKIP_STRUCTURE="false"
SKIP_BASH_SYNTAX="false"
SKIP_MCP_BUILD="false"
FALLOS=0

ok() {
  printf '[validate-local][OK] %s\n' "$1"
}

warn() {
  printf '[validate-local][WARN] %s\n' "$1"
}

fail() {
  printf '[validate-local][FAIL] %s\n' "$1"
  FALLOS=$((FALLOS + 1))
}

uso() {
  cat <<'EOF'
Uso:
  bash ci/scripts/validate-local.sh [opciones]

Opciones:
  --branch <rama>           Nombre de rama a validar.
  --commit-range <a..b>     Rango de commits para validar mensajes.
  --skip-branch             Omite validación de nombre de rama.
  --skip-commit             Omite validación de mensajes de commit.
  --skip-structure          Omite validación de estructura del repo.
  --skip-bash-syntax        Omite validación de sintaxis bash.
  --skip-mcp-build          Omite build de MCP.
  --help                    Muestra esta ayuda.
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --branch)
      BRANCH_NAME="${2:-}"
      shift 2
      ;;
    --commit-range)
      COMMIT_RANGE="${2:-}"
      shift 2
      ;;
    --skip-branch)
      SKIP_BRANCH="true"
      shift
      ;;
    --skip-commit)
      SKIP_COMMIT="true"
      shift
      ;;
    --skip-structure)
      SKIP_STRUCTURE="true"
      shift
      ;;
    --skip-bash-syntax)
      SKIP_BASH_SYNTAX="true"
      shift
      ;;
    --skip-mcp-build)
      SKIP_MCP_BUILD="true"
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

EN_GIT="false"
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  EN_GIT="true"
fi

if [[ "$SKIP_BRANCH" != "true" ]]; then
  if [[ -z "$BRANCH_NAME" && "$EN_GIT" == "true" ]]; then
    BRANCH_NAME="$(git branch --show-current 2>/dev/null || true)"
  fi

  if [[ -z "$BRANCH_NAME" ]]; then
    fail "No se pudo determinar la rama. Use --branch <nombre> o ejecute dentro de un repo Git."
  else
    if bash ci/scripts/validate-branch-name.sh "$BRANCH_NAME" >/dev/null; then
      ok "Nombre de rama válido: $BRANCH_NAME"
    else
      fail "Nombre de rama inválido: $BRANCH_NAME"
    fi
  fi
fi

if [[ "$SKIP_COMMIT" != "true" ]]; then
  if [[ "$EN_GIT" != "true" ]]; then
    fail "No hay repositorio Git; no se puede validar mensajes de commit."
  else
    SUBJECTS=""
    if [[ -n "$COMMIT_RANGE" ]]; then
      SUBJECTS="$(git log --format=%s "$COMMIT_RANGE" 2>/dev/null || true)"
      if [[ -z "$SUBJECTS" ]]; then
        warn "No se encontraron commits en rango $COMMIT_RANGE. Se valida solo HEAD."
      fi
    fi

    if [[ -z "$SUBJECTS" ]]; then
      SUBJECTS="$(git log -1 --format=%s HEAD 2>/dev/null || true)"
    fi

    if [[ -z "$SUBJECTS" ]]; then
      fail "No se pudo obtener asunto de commit para validar."
    else
      while IFS= read -r subject; do
        [[ -z "$subject" ]] && continue
        if echo "$subject" | bash ci/scripts/validate-commit-message.sh >/dev/null; then
          ok "Asunto de commit válido: $subject"
        else
          fail "Asunto de commit inválido: $subject"
        fi
      done <<< "$SUBJECTS"
    fi
  fi
fi

if [[ "$SKIP_STRUCTURE" != "true" ]]; then
  if bash ci/scripts/validate-repo-structure.sh . >/dev/null; then
    ok "Estructura del repositorio válida."
  else
    fail "Estructura del repositorio inválida."
  fi
fi

if [[ "$SKIP_BASH_SYNTAX" != "true" ]]; then
  if bash -n scripts/init-lab.sh \
      ci/scripts/validate-branch-name.sh \
      ci/scripts/validate-commit-message.sh \
      ci/scripts/validate-repo-structure.sh \
      ci/scripts/validate-local.sh \
      scripts/laboratorio/start-minimo.sh \
      scripts/laboratorio/validar-salud.sh \
      scripts/github/preflight-github.sh 2>/dev/null; then
    ok "Sintaxis bash válida."
  else
    fail "Falló validación de sintaxis bash."
  fi
fi

if [[ "$SKIP_MCP_BUILD" != "true" ]]; then
  if ! command -v npm >/dev/null 2>&1; then
    fail "npm no está disponible; no se puede validar build MCP."
  else
    if (cd mcp/oracle-apex && npm ci >/dev/null && npm run build >/dev/null); then
      ok "Build MCP Oracle/APEX válido."
    else
      fail "Falló build MCP Oracle/APEX."
    fi
    if (cd mcp/glpi && npm ci >/dev/null && npm run build >/dev/null); then
      ok "Build MCP GLPI válido."
    else
      fail "Falló build MCP GLPI."
    fi
  fi
fi

if [[ "$FALLOS" -gt 0 ]]; then
  printf '[validate-local][FAIL] Validación completada con %s fallo(s).\n' "$FALLOS"
  exit 1
fi

ok "Validación completada sin fallos."
