# Entornos DEV / QA / PROD

Separación lógica para el laboratorio y para pipelines. Cada subcarpeta incluye **README** y **`.env.example`** con variables de referencia (sin secretos).

| Carpeta | Rol |
|---------|-----|
| [dev/](dev/README.md) | Desarrollo activo, datos sintéticos |
| [qa/](qa/README.md) | Pruebas y regresión |
| [prod/](prod/README.md) | Estabilidad / demo controlada |

La **instancia Oracle** puede ser la misma en laboratorio; la separación es por **esquema**, **workspace APEX** y **variables de despliegue**.

Relación con GitLab: use el mismo repositorio y ramas; los jobs `deploy_*` deben mapear a estos entornos según [../docs/05-estrategia-ci-cd.md](../docs/05-estrategia-ci-cd.md).
