# Branding y lineamientos UI

## Objetivo

Asegurar coherencia visual entre **documentación**, **aplicaciones APEX** y canales institucionales usando la carpeta [../branding/](../branding/).

## Fuentes de verdad

| Artefacto | Ubicación |
|-----------|-----------|
| Paleta | [../branding/colors.json](../branding/colors.json) |
| Tipografía | [../branding/typography.md](../branding/typography.md) |
| Reglas UI | [../branding/ui-rules.md](../branding/ui-rules.md) |
| Logos e iconos | `branding/logos/`, `branding/icons/` (placeholders hasta assets reales) |

## APEX

- Plantillas y tema en `branding/apex-theme/` (estructura preparada).
- Universal Theme: personalizar **CSS** en `branding/css/` y mapear variables a `colors.json`.

## Accesibilidad

- Contraste mínimo **WCAG AA** para texto principal (validar al aplicar colores institucionales).
- Tamaños de fuente base **16px** equivalente mínimo en apps web.

## Documentación

- Diagramas y portadas de demo pueden usar la paleta definida en `colors.json` para reconocimiento de marca.

## Proceso de incorporación de marca real

1. Sustituir placeholders en `branding/logos/` y `branding/fonts/` (respetando licencias).
2. Actualizar `colors.json` con valores oficiales.
3. Regenerar capturas de la guía de demo [08-guia-de-demo.md](08-guia-de-demo.md).

## Referencias

- [../branding/README.md](../branding/README.md)
