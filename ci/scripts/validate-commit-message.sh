#!/usr/bin/env bash
# Valida el mensaje de commit (líneas por stdin o primer argumento).
# Formato: tipo(ámbito opcional): GLPI-<id> descripción
set -euo pipefail

MSG="${1:-}"
if [[ -z "$MSG" ]]; then
  MSG=$(cat)
fi

# Una línea de asunto obligatoria; permite cuerpo multilinea después
SUBJECT="${MSG%%$'\n'*}"

PATTERN='^(feat|fix|docs|ci|chore|refactor|test)(\([A-Za-z0-9._-]+\))?: GLPI-[0-9]+ .+'
if [[ "$SUBJECT" =~ $PATTERN ]]; then
  echo "Mensaje de commit válido (asunto)."
  exit 0
fi

# Permitir merge commits de GitLab sin GLPI (opcional en main)
if [[ "$SUBJECT" =~ ^Merge ]]; then
  echo "Aceptado como merge commit."
  exit 0
fi

echo "Asunto inválido: $SUBJECT"
echo "Esperado: tipo[(ámbito)]: GLPI-<número> descripción"
echo "Tipos: feat|fix|docs|ci|chore|refactor|test"
exit 1
