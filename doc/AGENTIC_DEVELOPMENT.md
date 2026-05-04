# 🤖 Desarrollo Agéntico — Turbo App

> Documentación del sistema agéntico que automatiza y agiliza el desarrollo del proyecto Turbo App.  
> Última actualización: Enero 2026

---

## 🎯 ¿Qué es el desarrollo agéntico aquí?

Es un sistema de **agentes Claude especializados** que colaboran siguiendo un workflow estricto basado en TDD y Clean Architecture, garantizando que toda nueva feature:

1. Sea **planificada** antes de codificar.
2. Tenga **tests primero** (mínimo 3 por feature).
3. Sea **implementada** con código mínimo que pase los tests.
4. Sea **documentada** automáticamente.
5. Pase un **review** integral antes de merge.

---

## 🧱 Arquitectura del sistema

```
┌────────────────────────────────────────────────────────────┐
│                       Usuario                              │
│          "Quiero añadir feature X"                         │
└────────────────────────┬───────────────────────────────────┘
                         │
                         ▼
                 ┌───────────────┐
                 │   /plan       │
                 │   PLANNER     │  ◄── Lee CLAUDE.md + doc/
                 │   (Opus)      │      Inspecciona código
                 └───────┬───────┘
                         │
                         ▼
              doc/features/<feature>.md
                         │
                         ▼
                 ┌───────────────┐
                 │   /tdd        │
                 │   ┌─────────┐ │
                 │   │ TESTER  │ │  RED 🔴
                 │   │ (Sonnet)│ │  → tests fallan
                 │   └────┬────┘ │
                 │        │      │
                 │        ▼      │
                 │   ┌─────────┐ │
                 │   │IMPLEMEN.│ │  GREEN 🟢
                 │   │ (Sonnet)│ │  → tests pasan
                 │   └────┬────┘ │
                 │        │      │
                 │        ▼      │
                 │   ┌─────────┐ │
                 │   │IMPLEMEN.│ │  REFACTOR 🔵
                 │   └─────────┘ │
                 └───────┬───────┘
                         │
                         ▼
                 ┌───────────────┐
                 │   /doc        │
                 │  DOCUMENTER   │  → doc/features/, CHANGELOG
                 │  (Sonnet)     │
                 └───────┬───────┘
                         │
                         ▼
                 ┌───────────────┐
                 │   /review     │
                 │  Validación   │  → 🟢 / 🟡 / 🔴
                 └───────┬───────┘
                         │
                         ▼
                       MERGE
```

---

## 👥 Los 4 agentes

### 1. 🧭 Planner (`.claude/agents/planner.md`)

- **Rol:** Estratega y arquitecto.
- **Trigger:** `/plan <descripción>`
- **Modelo recomendado:** Opus (mayor capacidad de razonamiento).
- **Inputs:** Descripción en lenguaje natural.
- **Outputs:** Plan en `doc/features/<feature>.md`.
- **Cuándo usarlo:** Al inicio de TODA nueva feature, mejora o bug fix.

### 2. 🧪 Tester (`.claude/agents/tester.md`)

- **Rol:** Guardián de la calidad. Escribe los **3 tests obligatorios** antes que exista el código.
- **Trigger:** `/test <feature>`
- **Modelo recomendado:** Sonnet (rapidez con suficiente rigor).
- **Inputs:** Plan aprobado o descripción de bug.
- **Outputs:** Tests fallando (RED).
- **Cuándo usarlo:** Antes de toda implementación. Para reproducir bugs.

### 3. 🔨 Implementer (`.claude/agents/implementer.md`)

- **Rol:** Constructor. Escribe el código mínimo para hacer pasar los tests.
- **Trigger:** `/implement`
- **Modelo recomendado:** Sonnet (velocidad).
- **Inputs:** Tests RED + plan.
- **Outputs:** Código de producción + DI + rutas + i18n.
- **Cuándo usarlo:** Después de `/test`. Para hacer fixes de bugs.

### 4. 📚 Documenter (`.claude/agents/documenter.md`)

- **Rol:** Cronista. Mantiene `doc/` y `CLAUDE.md` sincronizados con el código.
- **Trigger:** `/doc`
- **Modelo recomendado:** Sonnet.
- **Inputs:** Feature implementada.
- **Outputs:** Actualización en `doc/features/`, `CHANGELOG.md`, `MVP_PRIORITIES.md`.
- **Cuándo usarlo:** Tras toda implementación.

---

## 🎮 Comandos disponibles

| Comando        | Agente(s)              | Pre-requisitos                  | Outputs                        |
|----------------|------------------------|----------------------------------|--------------------------------|
| `/plan`        | Planner                | Descripción de la feature       | Plan en `doc/features/`        |
| `/feature`     | (scaffold)             | Nombre de la feature            | Carpetas vacías en `lib/` y `test/` |
| `/tdd`         | Tester + Implementer   | Plan aprobado                   | Tests + código + DI + i18n     |
| `/test`        | Tester                 | (opcional) Plan / bug           | Tests RED                      |
| `/implement`   | Implementer            | Tests RED                       | Código GREEN + refactor        |
| `/doc`         | Documenter             | Feature implementada            | doc/ actualizada               |
| `/review`      | Validador integral     | Cambios listos                  | Reporte 🟢/🟡/🔴               |

---

## 🔁 Workflows estandarizados

### `feature_workflow.md` — Crear nueva feature E2E
`/plan` → `/tdd` → `/doc` → `/review`

### `tdd_workflow.md` — Ciclo TDD detallado
RED → GREEN → REFACTOR

### `bugfix_workflow.md` — Arreglar bugs
Reproducir → test que falla → fix → test pasa → doc

### `mvp_workflow.md` — Lanzar MVP
Sprint 1 estabilización → Sprint 2 features faltantes → Sprint 3 pulido → Sprint 4 lanzamiento

---

## 🧪 Política TDD del proyecto

### Regla de oro: 3 tests mínimo por feature

| # | Tipo                | Pregunta                                              |
|---|---------------------|-------------------------------------------------------|
| 1 | Estado inicial      | ¿El cubit se construye con el estado correcto?       |
| 2 | Caso éxito          | ¿Emite los estados esperados ante éxito?              |
| 3 | Caso error          | ¿Maneja errores y emite estado de error?              |

### Recomendados (cuando aplique)

- Lista vacía / sin resultados
- Múltiples llamadas
- Validación de input
- Verificación de llamadas (`verify(...).called(N)`)

### Cobertura objetivo

- `state_management/`: ≥ 80%
- `module/`: ≥ 80%
- Total proyecto: ≥ 60%

---

## 📋 Convenciones obligatorias (resumen)

Las reglas completas están en `CLAUDE.md` § 8. Las críticas:

| ❌ Prohibido                          | ✅ Hacer                                |
|---------------------------------------|----------------------------------------|
| `print(...)`                          | `debugPrint(...)`                      |
| `Color(0xFF...)`                      | `TurboColors.X`                        |
| `.withOpacity(0.5)`                   | `.withValues(alpha: 0.5)`              |
| `Text('literal')`                     | `Text(context.l10n.X)`                 |
| `context.router.pop()`                | `context.router.maybePop()`            |
| `context.router.pushPath('/x')`       | `context.router.push(XRoute())`        |
| Cubit sin tests                       | Cubit con ≥ 3 tests                    |
| State sin freezed                     | `@freezed sealed class XState`         |
| Archivos > 500 líneas                 | Extraer widgets                        |
| Lógica en `build()`                   | Lógica en Cubit / Use Case             |

---

## 🔧 Setup inicial del proyecto agéntico

### Para nueva sesión de Claude

1. Asegurarse que existen:
   - `/CLAUDE.md`
   - `/.claude/` con agentes y comandos
   - `/doc/AGENTIC_DEVELOPMENT.md` (este archivo)

2. Comando recomendado al iniciar:
   ```
   /plan "<lo que quiero hacer hoy>"
   ```

3. Seguir los próximos pasos sugeridos por cada agente.

### Para añadir un agente nuevo

1. Crear `.claude/agents/<nuevo-agente>.md` con frontmatter YAML.
2. Registrarlo en `.claude/settings.json` → `agents`.
3. Crear comando asociado en `.claude/commands/<comando>.md`.
4. Documentar en este archivo.

---

## 🏃 Ejemplo: añadir feature "recuperación de contraseña"

### Paso 1 — Planificación

```
/plan Añadir pantalla de recuperación de contraseña con email.
       Usar Firebase Auth (ya integrado). Debe haber validación de email,
       mensaje de éxito al enviar, y manejo de errores comunes.
```

→ Planner genera `doc/features/password-recovery.md` con:
- 4 archivos a crear, 3 a modificar
- 5 tests planificados
- Estimación: 4-6 horas
- Riesgos: Firebase rate limit (mitigación: debounce)

### Paso 2 — Aprobación

Usuario revisa el plan, dice "Aprobado".

### Paso 3 — TDD

```
/tdd
```

→ Tester escribe en `test/authentication/cubit/forgot_password_cubit_test.dart`:
1. Estado inicial
2. Email enviado correctamente (loading → success)
3. Email inválido (loading → error)
4. Rate limit de Firebase (loading → error específico)

Ejecuta tests → fallan (RED ✅).

→ Implementer crea:
- `forgot_password_state.dart` (sealed)
- `forgot_password_cubit.dart`
- `send_password_reset_use_case.dart`
- `forgot_password_screen.dart`
- Registra en `init_config.dart`
- Añade ruta en `app_router.dart`
- Añade claves en ARBs (`forgotPassword*`)

Ejecuta tests → pasan (GREEN ✅).

Refactoriza (extrae widget de form) → tests siguen pasando.

### Paso 4 — Documentación

```
/doc
```

→ Documenter actualiza:
- `doc/features/password-recovery.md` con resultado real
- `doc/CHANGELOG.md` añadiendo en Unreleased
- `doc/MVP_PRIORITIES.md` marcando `[x]`

### Paso 5 — Review

```
/review
```

→ 🟢 LISTA PARA MERGE.

### Paso 6 — Commit

```bash
git commit -m "feat(authentication): add password recovery screen

- New ForgotPasswordCubit with sealed state
- New SendPasswordResetUseCase
- New /forgot-password route
- Tests: 4/4 passing, coverage 92%
- i18n: ES/EN

Closes #42"
```

---

## 📊 Métricas del sistema agéntico

Después de cada release, registrar en `doc/RETROSPECTIVE.md`:

- Features completadas con sistema agéntico vs. manualmente.
- Tiempo medio por feature.
- Bugs encontrados post-merge (deberían tender a 0).
- Cobertura promedio.
- Quejas/sugerencias del developer.

---

## 🚧 Limitaciones conocidas

1. **Curva de aprendizaje**: la primera feature toma más tiempo (familiarizarse con el flujo).
2. **Setup inicial**: requiere que `CLAUDE.md` y `.claude/` estén bien definidos.
3. **No reemplaza juicio humano**: el usuario debe aprobar planes y revisar reviews.
4. **Dependencia de modelos**: la calidad varía según el modelo (Opus mejor para Planner).

---

## 🔮 Roadmap del sistema agéntico

### v1.0 (actual)
- 4 agentes: Planner, Tester, Implementer, Documenter.
- 7 comandos.
- 4 workflows.
- Plantillas reutilizables.

### v1.1 (próximo)
- [ ] Agente Reviewer dedicado (separado de comando `/review`).
- [ ] Comando `/refactor` para refactors aislados.
- [ ] Integración con CI/CD (auto-tests en cada PR).
- [ ] Plantillas de widgets de UI complejos.

### v2.0 (futuro)
- [ ] Auto-generación de ADRs cuando el Planner detecta decisión arquitectónica.
- [ ] Detección automática de deuda técnica.
- [ ] Métricas de cobertura por agente.

---

**Recuerda:** el sistema agéntico amplifica al developer, no lo reemplaza. La supervisión humana sigue siendo crítica.
