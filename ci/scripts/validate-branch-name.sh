#!/usr/bin/env bash
# Valida el nombre de rama frente a convenciones del proyecto (docs/04).
set -euo pipefail
BRANCH="${1:-}"
if [[ -z "$BRANCH" ]]; then
  echo "Uso: validate-branch-name.sh <nombre-de-rama>"
  exit 2
fi

ALLOW='^(main|develop|(feature|bugfix|hotfix|release)/[A-Za-z0-9._-]+|v[0-9]+\.[0-9]+\.[0-9]+)$'
if [[ "$BRANCH" =~ $ALLOW ]]; then
  echo "Rama válida: $BRANCH"
  exit 0
fi

echo "Rama no permitida: $BRANCH"
echo "Patrón esperado: main, develop, feature/*, bugfix/*, release/*, hotfix/*"
exit 1
