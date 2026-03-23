# Prompt: crear rama desde ticket

Ticket GLPI: **{{GLPI_ID}}**  
Tipo de trabajo: **{{TIPO}}** (feature | bugfix | hotfix)  
Breve descripción: **{{DESCRIPCION}}**

**Tarea:**

1. Propón un nombre de rama según `docs/04-estandares-de-ramas-y-commits.md`.
2. Indica desde qué rama base debemos ramificar (`develop` o `main` para hotfix).
3. Lista los primeros 3 commits sugeridos (solo asuntos) con formato convencional + `GLPI-{{GLPI_ID}}`.

Salida en español, comandos `git` listos para copiar.
