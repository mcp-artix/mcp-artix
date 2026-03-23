# Volúmenes Docker

Los volúmenes **nombrados** se declaran al final de [../docker-compose.yml](../docker-compose.yml):

- `oracle_data` — ficheros de datos Oracle
- `mariadb_data` — datos GLPI
- `gitlab_*` — configuración y datos GitLab (si usa perfil `gitlab`)
- `gitlab_runner_config` — registro del runner

## Buenas prácticas

- Backup antes de `docker compose down -v`.
- No enlazar rutas sensibles del host sin cifrado en equipos portátiles.
