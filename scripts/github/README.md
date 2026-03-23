# Scripts GitHub (modo puente)

| Script | Uso |
|--------|-----|
| [preflight-github.sh](preflight-github.sh) | Valida que exista repositorio Git local y remote `origin` hacia GitHub antes de activar el flujo puente |
| [bootstrap-local.sh](bootstrap-local.sh) | Inicializa Git local y configura `origin` hacia GitHub para arrancar el modo puente |

## Uso

Desde la raíz del repositorio:

```bash
bash scripts/github/preflight-github.sh
```

Si falla porque no existe `.git`, inicializar primero repositorio local y luego configurar `origin`.

Atajo de inicialización:

```bash
bash scripts/github/bootstrap-local.sh --origin git@github.com:<org-o-usuario>/empornac-ai-dev-platform.git --crear-main
```
