# Reverse proxy opcional (Caddy / Traefik / Nginx)

## Objetivo

Unificar **hostnames locales** y, si se desea, **TLS de demostración** para Oracle APEX/ORDS, GLPI y GitLab sin recordar puertos dispersos.

## Estado en el repositorio

La carpeta [../../infra/reverse-proxy/](../../infra/reverse-proxy/) contiene **plantillas y notas**. No es obligatoria para el primer arranque del laboratorio.

## Cuándo usarla

- Demostración ante stakeholders con URLs limpias (`glpi.lab.local`, `apex.lab.local`).
- Terminación TLS local con certificados autofirmados o **mkcert** (solo desarrollo).

## Enfoque típico con Caddy (ejemplo conceptual)

1. Añadir entradas en `/etc/hosts` del Mac apuntando a `127.0.0.1`.
2. Archivo `Caddyfile` que enrute:

   - `glpi.lab.local` → servicio `glpi:80`
   - `gitlab.lab.local` → servicio `gitlab:80` (si aplica)

3. Levantar Caddy con `docker compose --profile proxy` cuando se añada el servicio al compose (futuro).

## TLS

En laboratorio, los certificados autofirmados generan avisos en el navegador; es **aceptable** para demo interna. **No** reutilice ese modelo en producción sin PKI institucional.

## Referencia

- [../../infra/reverse-proxy/README.md](../../infra/reverse-proxy/README.md)
