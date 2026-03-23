# Prompt: generar hotfix

Incidente / ticket: **GLPI-{{ID}}**  
Síntoma:  
{{SINTOMA}}

**Instrucciones:**

1. Define rama `hotfix/GLPI-{{ID}}-<slug>` desde `main`.
2. Propón el parche mínimo (archivos o áreas probables).
3. Commits sugeridos (asuntos).
4. Plan de merge a `main` y **backport** a `develop`.
5. Riesgos si el hotfix toca datos o DDL.

Idioma español. Sin datos productivos.
