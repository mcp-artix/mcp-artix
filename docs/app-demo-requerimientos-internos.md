# Sistema de Gestión de Requerimientos Internos — diseño inicial

## Visión

Aplicación **demo** en Oracle APEX que centraliza **requerimientos internos** de áreas usuarias, su priorización, estado y vínculo con **tickets GLPI** y con el **ciclo DEV/QA/PROD**.

## Módulos propuestos

1. **Registro de requerimientos** — alta, edición, adjuntos ligeros (laboratorio).
2. **Bandeja del área solicitante** — seguimiento del propio usuario.
3. **Mesa de análisis** — clasificación, estimación, decisión de alcance.
4. **Vinculación GLPI** — ID ticket, tipo (incidente/cambio/proyecto), enlace externo.
5. **Tablero de estado** — kanban por estado de requerimiento.
6. **Auditoría básica** — quién cambió estado y cuándo (tabla de log).

## Entidades principales

| Entidad | Descripción |
|---------|-------------|
| `REQ_REQUERIMIENTO` | Núcleo: título, descripción, solicitante, área, prioridad, fechas |
| `REQ_ESTADO` | Catálogo: borrador, en_análisis, aprobado, en_desarrollo, en_qa, en_prod, rechazado |
| `REQ_COMENTARIO` | Seguimientos y notas |
| `REQ_ADJUNTO` | Metadatos de archivo (BLOB opcional en laboratorio) |
| `REQ_GLPI_ENLACE` | ID externo, URL, tipo de ítem GLPI |

## Flujo de estados

```text
borrador → en_análisis → aprobado → en_desarrollo → en_qa → en_prod
                ↘ rechazado
```

## Requerimientos funcionales iniciales

- RF-01: Crear requerimiento en estado borrador.
- RF-02: Enviar a análisis con validación de campos mínimos.
- RF-03: Registrar ID GLPI asociado (manual en demo).
- RF-04: Cambiar estado solo por roles definidos (admin, analista, desarrollador de prueba).
- RF-05: Listar y filtrar por área, estado y rango de fechas.

## Requerimientos no funcionales

- RNF-01: Tiempos de respuesta aceptables en laboratorio (< 2s página típica).
- RNF-02: UI alineada a [10-branding-y-lineamientos-ui.md](10-branding-y-lineamientos-ui.md).
- RNF-03: Separación de datos por entorno (esquema DEV distinto de QA en laboratorio).

## Trazabilidad con GLPI

- Cada requerimiento **aprobado para desarrollo** debe referenciar un ticket GLPI de tipo **Cambio** o **Proyecto** (según política).
- Comentarios en GLPI enlazan al número de requerimiento APEX.

## Relación con DEV / QA / PROD

| Entorno | Uso de la app |
|---------|----------------|
| DEV | Desarrollo de páginas y paquetes PL/SQL |
| QA | Datos de prueba y regresión |
| PROD (demo) | Congelación de versión exportada en Git |

## Estrategia de construcción en APEX

1. Crear workspace y esquema por entorno según [../environments/](../environments/).
2. DDL base en [../database/ddl/](../database/ddl/) (tablas catálogo y transaccionales).
3. Paquetes API en `database/packages/` si se desea capa PL/SQL.
4. Construcción de app APEX (ID sugerido **100** en laboratorio — ajustable).
5. Export **split** a [../apex/exports/](../apex/exports/) tras cada hito.
6. Integración CI: job `export_apex` (cuando Runner y SQLcl estén disponibles).

## Estructura en el repositorio

- Documento maestro: este fichero.
- Carpeta sugerida para artefactos: [../apex/apps/demo-requerimientos-internos/README.md](../apex/apps/demo-requerimientos-internos/README.md).
