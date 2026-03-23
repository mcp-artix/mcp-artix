#!/usr/bin/env bash
# Comprueba que GITLAB_SERVER_URL esté definida en infra/.env (sin hacer source del archivo completo).
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
ENV_FILE="$ROOT/infra/.env"

if [[ ! -f "$ENV_FILE" ]]; then
  echo "Aviso: no existe $ENV_FILE — copie desde infra/.env.example"
  exit 1
fi

GITLAB_SERVER_URL=""
while IFS= read -r line || [[ -n "$line" ]]; do
  [[ "$line" =~ ^[[:space:]]*# ]] && continue
  if [[ "$line" =~ ^GITLAB_SERVER_URL= ]]; then
    GITLAB_SERVER_URL="${line#GITLAB_SERVER_URL=}"
    GITLAB_SERVER_URL="${GITLAB_SERVER_URL//\"/}"
    GITLAB_SERVER_URL="${GITLAB_SERVER_URL//\'/}"
    break
  fi
done < "$ENV_FILE"

if [[ -z "$GITLAB_SERVER_URL" ]]; then
  echo "Defina GITLAB_SERVER_URL en infra/.env (URL HTTPS de su GitLab)."
  exit 1
fi

if [[ "$GITLAB_SERVER_URL" == *"empresa.interna"* ]]; then
  echo "Sustituya el placeholder empresa.interna por la URL real de su GitLab."
  exit 1
fi

echo "GITLAB_SERVER_URL=$GITLAB_SERVER_URL"

GITLAB_REMOTE_SSH_HOST=""
while IFS= read -r line || [[ -n "$line" ]]; do
  [[ "$line" =~ ^[[:space:]]*# ]] && continue
  if [[ "$line" =~ ^GITLAB_REMOTE_SSH_HOST= ]]; then
    GITLAB_REMOTE_SSH_HOST="${line#GITLAB_REMOTE_SSH_HOST=}"
    GITLAB_REMOTE_SSH_HOST="${GITLAB_REMOTE_SSH_HOST//\"/}"
    break
  fi
done < "$ENV_FILE"

echo "GITLAB_REMOTE_SSH_HOST=${GITLAB_REMOTE_SSH_HOST:-no definido}"
echo ""
echo "Siguiente paso: registrar un Runner contra esa URL (token desde GitLab UI):"
echo "  gitlab-runner register --url \"$GITLAB_SERVER_URL\" --token \"<TOKEN>\" ..."
echo "Detalle: docs/instalacion/05-gitlab-runner.md"
