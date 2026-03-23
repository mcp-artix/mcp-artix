# Prompt: preparar despliegue a QA

Release o MR: **{{REFERENCIA}}**

Elabora una checklist en español para el despliegue a **QA** que incluya:

- Orden de aplicación: DDL → DML → import APEX → smoke tests.  
- Variables a verificar en `environments/qa/.env.example` vs CI.  
- Datos de prueba necesarios (solo sintéticos).  
- Criterio de “QA lista” para notificar al solicitante.  
- Enlace sugerido al comentario en ticket GLPI.

Referencia: `docs/05-estrategia-ci-cd.md` y job `deploy_qa`.
