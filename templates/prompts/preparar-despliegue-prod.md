# Prompt: preparar despliegue a PROD

Cambio aprobado: **GLPI-{{ID}}**  
Versión: **{{VERSION}}**

Genera en **español**:

1. Checklist pre-producción (backup, ventana, comunicación).  
2. Orden de ejecución alineado a control de cambios.  
3. Plan de **rollback** con criterio de activación.  
4. Validaciones post-despliegue (smoke tests).  
5. Texto breve para cierre de ticket y registro de cambio.

**Importante:** recordar que el job `deploy_prod` es **manual** y requiere aprobadores configurados en GitLab.
