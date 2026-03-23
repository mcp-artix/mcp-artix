# Scripts de laboratorio mínimo

Scripts orientados al **Sprint 1** para dejar un arranque reproducible y verificable del laboratorio mínimo.

| Script | Propósito |
|--------|-----------|
| [start-minimo.sh](start-minimo.sh) | Levanta Oracle + MariaDB + GLPI y opcionalmente el perfil `mcp` |
| [validar-salud.sh](validar-salud.sh) | Verifica estado de contenedores, puertos y salud HTTP; opcionalmente valida MCP |

## Uso rápido

Desde la raíz del repositorio:

```bash
bash scripts/laboratorio/start-minimo.sh
bash scripts/laboratorio/validar-salud.sh
```

Con perfil MCP en Docker:

```bash
bash scripts/laboratorio/start-minimo.sh --con-mcp-compose
bash scripts/laboratorio/validar-salud.sh --con-mcp-compose
```

Validación de compilación MCP en host (Node.js + npm):

```bash
bash scripts/laboratorio/validar-salud.sh --con-mcp-build
```
