# Guía de demostración

## Audiencia

Equipo de desarrollo, arquitectura o gestión que desea ver **trazabilidad** entre GLPI, GitLab y APEX en un laboratorio Docker.

## Duración sugerida

45–60 minutos, con servicios ya levantados o arranque en paralelo explicado.

## Preparación

1. Seguir [11-guia-instalacion-laboratorio.md](11-guia-instalacion-laboratorio.md).
2. Tener un ticket GLPI de ejemplo (o crearlo durante la demo).
3. Clonar el repositorio y mostrar estructura en IDE.

## Guión (alto nivel)

### 1. Contexto metodológico (5 min)

- Ticket como unidad de trabajo.
- Ramas `feature/GLPI-…` y commits con referencia al ticket.

### 2. GLPI (10 min)

- Crear o mostrar ticket de tipo **desarrollo**.
- Mostrar estados: nuevo → en curso → pendiente QA → cerrado.

### 3. GitLab (15 min)

- MR con plantilla [../templates/gitlab/merge_request_templates/default.md](../templates/gitlab/merge_request_templates/default.md).
- Pipeline: stage **validate** en verde.
- Explicar que **deploy_prod** es **manual**.

### 4. Oracle / APEX (15 min)

- Acceso al workspace de **DEV**.
- Mostrar app “Sistema de Gestión de Requerimientos Internos” (diseño en [app-demo-requerimientos-internos.md](app-demo-requerimientos-internos.md)).
- Mencionar export **split** bajo `apex/exports/`.

### 5. MCP (10 min)

- Arrancar `mcp/oracle-apex` y `mcp/glpi` en modo desarrollo.
- Invocar una tool **stub** y mostrar respuesta estructurada y mensaje de “pendiente de implementación”.

### 6. Cierre

- Referencia a [09-riesgos-y-controles.md](09-riesgos-y-controles.md) y próximos pasos en [99-resumen-iteracion-y-siguientes-pasos.md](99-resumen-iteracion-y-siguientes-pasos.md).

## Mensajes clave

- **Separación de entornos** no es opcional para instituciones maduras.
- **La IA acelera**, no reemplaza aprobaciones ni control de cambios.
- **Laboratorio ≠ producción**: contraseñas y datos son de prueba.

## Materiales

- Diagrama en [01-arquitectura-general.md](01-arquitectura-general.md)
- Branding: [10-branding-y-lineamientos-ui.md](10-branding-y-lineamientos-ui.md)
