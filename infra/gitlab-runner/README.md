# GitLab Runner (perfil `runner`)

## Rol

Ejecutar jobs definidos en [.gitlab-ci.yml](../../.gitlab-ci.yml) con executor **docker**.

## Registro

El token **no** va en Git. Obténgalo en GitLab y ejecute `gitlab-runner register` dentro del contenedor. Procedimiento: [../../docs/instalacion/05-gitlab-runner.md](../../docs/instalacion/05-gitlab-runner.md).

## Socket Docker

El compose monta `/var/run/docker.sock` para que el runner lance contenedores hermanos. **Riesgo de seguridad** en entornos compartidos; aceptable solo en laboratorio aislado.

## GitLab externo

Si no usa el servicio `gitlab` del compose, registre el runner igualmente contra la URL de su instancia SaaS o corporativa.
