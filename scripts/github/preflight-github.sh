#!/usr/bin/env bash
# Comprobación previa para modo puente con GitHub.
set -euo pipefail

if ! command -v git >/dev/null 2>&1; then
  echo "[ERROR] git no está disponible en PATH."
  exit 1
fi

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "[ERROR] Este directorio no es un repositorio Git."
  echo "Inicialice Git y luego configure origin hacia GitHub."
  echo "Ejemplo:"
  echo "  git init -b develop"
  echo "  git remote add origin git@github.com:<org-o-usuario>/empornac-ai-dev-platform.git"
  exit 1
fi

ORIGIN_URL="$(git remote get-url origin 2>/dev/null || true)"
if [[ -z "$ORIGIN_URL" ]]; then
  echo "[ERROR] No existe remote 'origin'."
  echo "Configure origin hacia GitHub."
  exit 1
fi

echo "[OK] Repositorio Git detectado."
echo "[OK] origin=$ORIGIN_URL"

if [[ "$ORIGIN_URL" != *"github.com"* ]]; then
  echo "[WARN] origin no parece GitHub. Continúe solo si usa un mirror compatible."
else
  echo "[OK] origin apunta a GitHub."
fi

CURRENT_BRANCH="$(git branch --show-current 2>/dev/null || true)"
if [[ -n "$CURRENT_BRANCH" ]]; then
  echo "[OK] Rama actual: $CURRENT_BRANCH"
else
  echo "[WARN] No se pudo determinar rama actual (repositorio vacío o HEAD detached)."
fi

echo ""
echo "Siguiente paso recomendado:"
echo "  1) Push de rama develop/main."
echo "  2) Activar workflows en Actions."
echo "  3) Configurar protección de ramas y entornos (qa/prod)."
