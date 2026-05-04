# ADR-0001: Adopción de un sistema de desarrollo agéntico con TDD

**Estado:** Aceptada  
**Fecha:** 2026-01-26  
**Autores:** Equipo Turbo

---

## Contexto

El proyecto Turbo App está en fase final de MVP. Queremos lanzar pronto pero también:
- Mantener una arquitectura coherente (Clean Architecture + BLoC) ya establecida.
- Reducir bugs y regresiones en producción.
- Acelerar el desarrollo con asistencia de IA (Claude).
- Garantizar que cada nueva contribución sigue las mismas convenciones, sin importar quién la haga.

Sin un sistema formalizado, observamos:
- Inconsistencias en la estructura de archivos por feature.
- Falta de tests en features nuevas (cobertura ~15%).
- Documentación desactualizada respecto al código.
- Anti-patrones recurrentes (`withOpacity`, strings literales, `print()`).

---

## Decisión

Adoptamos un **sistema de desarrollo agéntico** con 4 agentes Claude especializados que colaboran siguiendo un workflow **TDD obligatorio**:

1. **Planner** — diseña planes antes de codificar.
2. **Tester** — escribe los 3+ tests RED antes que exista el código.
3. **Implementer** — hace el código mínimo que pase los tests (GREEN).
4. **Documenter** — mantiene `doc/` y `CLAUDE.md` actualizados.

**Política asociada:**
- **Mínimo 3 tests por feature** (estado inicial, caso éxito, caso error).
- **Cobertura objetivo ≥ 80%** en `state_management/` y `module/`.
- **`CLAUDE.md`** como guía maestra obligatoria al iniciar cualquier sesión.
- **Comandos invocables** (`/plan`, `/tdd`, `/test`, `/implement`, `/doc`, `/feature`, `/review`) que orquestan a los agentes.
- **Workflows estandarizados** (`feature_workflow.md`, `tdd_workflow.md`, `bugfix_workflow.md`, `mvp_workflow.md`).

---

## Alternativas consideradas

### Opción A: Mantener desarrollo manual sin sistema agéntico
**Descartada porque:**
- No escala con el tiempo limitado para el MVP.
- Las inconsistencias siguen apareciendo.
- La cobertura de tests no mejora.

### Opción B: Solo usar Claude como autocomplete (sin agentes definidos)
**Descartada porque:**
- Cada sesión empieza de cero, sin contexto del proyecto.
- Claude propone patrones que no coinciden con la convención existente.
- No hay garantía de tests escritos antes del código.

### Opción C: Adoptar TDD sin agentes, con scripts manuales
**Descartada porque:**
- Aporta el rigor de testing pero no la velocidad de IA.
- No automatiza la documentación.
- Mayor fricción para el developer.

### Opción D (elegida): Sistema agéntico + TDD obligatorio + CLAUDE.md
**Ventajas:**
- Combina velocidad de IA con rigor de TDD.
- Cada agente tiene un rol claro y reglas estrictas.
- El developer humano supervisa y aprueba (no es 100% automático).
- Los outputs son consistentes entre features y entre developers.

---

## Consecuencias

### Positivas

1. **Coherencia arquitectónica garantizada**: cada feature sigue exactamente la misma estructura.
2. **Tests siempre escritos primero**: imposible saltarse TDD.
3. **Cobertura aumenta progresivamente**: cada nueva feature añade ≥ 3 tests.
4. **Documentación viva**: el Documenter actualiza `doc/` automáticamente.
5. **Onboarding rápido**: nuevos developers leen `CLAUDE.md` y `AGENTIC_DEVELOPMENT.md` y están operativos.
6. **Reducción de bugs en producción**: por mayor cobertura y reviews sistemáticos.
7. **Velocidad de feature aumenta tras la primera**: la curva de aprendizaje es de 1-2 features.

### Negativas

1. **Curva de aprendizaje inicial**: la primera feature toma más tiempo (1.5x).
2. **Dependencia de Claude**: si el modelo no está disponible, el flujo se rompe.
3. **Requiere disciplina**: el developer puede saltarse el flujo y volver a malas prácticas.
4. **Mantenimiento de `.claude/` y `CLAUDE.md`**: si la arquitectura cambia, hay que actualizarlo.
5. **Limitaciones de modelos**: Opus es caro; Sonnet puede no ser suficiente para Planner en features muy complejas.

### Mitigaciones

- **Curva de aprendizaje**: el primer use case (recuperación de contraseña) servirá como demo del flujo.
- **Dependencia de Claude**: los workflows están documentados de forma que un humano pueda seguirlos sin IA.
- **Disciplina**: agregar `/review` al pre-commit hook a futuro.
- **Mantenimiento**: el agente Documenter incluye instrucciones para actualizar `CLAUDE.md`.

---

## Cumplimiento

Verificamos que esta ADR se respeta cuando:

- [ ] Existe `/CLAUDE.md` actualizado.
- [ ] Existe `/.claude/` con agentes, comandos, workflows y plantillas.
- [ ] Cada nueva feature tiene un archivo `doc/features/<feature>.md`.
- [ ] Cada Cubit tiene ≥ 3 tests en `test/<feature>/cubit/`.
- [ ] `doc/CHANGELOG.md` se actualiza por feature.
- [ ] `flutter analyze` está limpio.
- [ ] Los anti-patrones de `CLAUDE.md` § 8 no aparecen en código nuevo.

**Verificación automática:** invocar `/review` antes de cada merge.

---

## Referencias

- `/CLAUDE.md` — guía maestra.
- `/.claude/README.md` — descripción del sistema.
- `doc/AGENTIC_DEVELOPMENT.md` — documentación detallada.
- `doc/TDD_GUIDE.md` — política de testing.
- `doc/CONVENTIONS.md` — convenciones de código.

---

**Próxima revisión:** post-lanzamiento del MVP. Evaluar métricas:
- Velocidad media por feature antes vs. después.
- Cobertura de tests antes vs. después.
- Bugs en producción antes vs. después.
