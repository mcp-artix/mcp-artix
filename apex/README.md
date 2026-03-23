# Oracle APEX (artefactos versionados)

## Contenido

| Carpeta | Uso |
|---------|-----|
| `apps/` | Documentación por aplicación |
| `workspaces/` | Notas de workspace (no export completo del workspace salvo política explícita) |
| `templates/` | Plantillas de componentes reutilizables |
| `static-files/` | Referencias o copias de archivos estáticos (sin binarios pesados sin LFS) |
| `exports/` | Salida de `apex export` (full o split) |
| `imports/` | Scripts o paquetes para importación automatizada |

## Export full vs split

- **Full:** un `.sql` por aplicación; simple, diffs grandes en Git.
- **Split:** directorio con muchos ficheros; **recomendado** para revisión en MR.

Ver [../docs/instalacion/03-sqlcl-export-import.md](../docs/instalacion/03-sqlcl-export-import.md).

## Versionado en Git

- No commitear **sesiones** ni credenciales.
- Tras cada cambio sustancial en DEV: export split → commit con mensaje que referencie ticket GLPI.

## App demo

[apps/demo-requerimientos-internos/README.md](apps/demo-requerimientos-internos/README.md)
