# Riesgos y controles

## Matriz resumida

| Riesgo | Impacto | Probabilidad | Mitigación |
|--------|---------|--------------|------------|
| Fuga de secretos en Git | Alto | Media | `.gitignore`, revisión MR, secret scanning en GitLab |
| Imagen Docker maliciosa o desactualizada | Alto | Baja | Registries aprobados, versionado fijo de tags, auditoría |
| Sobrecarga de Mac / OOM | Medio | Alta | Perfiles compose, no levantar GitLab+Oracle sin RAM suficiente |
| Emulación amd64 lenta / inestable | Medio | Media | GitLab SaaS, BD remota, VM x86 |
| SQL arbitrario vía MCP | Alto | Media | Solo lectura, cuentas limitadas, stubs hasta política aprobada |
| Despliegue PROD no autorizado | Alto | Baja | Job manual, environments protegidos, doble aprobación |
| Drift documentación vs compose | Medio | Media | Checklist en README; MR debe actualizar docs si cambia infra |
| Datos personales en laboratorio | Alto | Baja | Datos sintéticos; anonimizar si se importan dumps |

## Controles organizacionales (recomendados)

- **Control de cambios** para PROD con ticket GLPI tipo **Cambio**.
- **Revisiones obligatorias** en MR hacia `main` y `develop`.
- **Backups** de volúmenes Docker antes de actualizar GLPI u Oracle.

## Controles técnicos (laboratorio)

- Red `internal` en Docker para servicios que no necesitan exposición al host.
- Contraseñas en `.env` fuera de Git; rotar al clonar para demo pública.

## Parametrización pendiente (riesgo operativo)

Lista viva; alinear con [00-arquitectura-inicial.md](00-arquitectura-inicial.md):

- Aprobadores de `deploy_prod` en GitLab.
- Clasificación de datos permitidos en QA/PROD de laboratorio.
- Política de retención de artefactos CI.

## Incidentes

- Registrar **problema** en GLPI si la demo falla en contexto institucional.
- Post-mortem breve enlazado al ticket y al MR de corrección.
