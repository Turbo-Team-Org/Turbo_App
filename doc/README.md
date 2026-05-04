# 📚 Documentación — Turbo App

> Centro de documentación del proyecto Turbo App.  
> Última actualización: Enero 2026.

---

## 🚦 Quick Start

### Para Claude (nueva sesión)
1. Lee `/CLAUDE.md` (raíz) — guía maestra del proyecto.
2. Lee `AGENTIC_DEVELOPMENT.md` — sistema agéntico.
3. Invoca `/plan <descripción>` para empezar.

### Para developers humanos
1. Lee `MVP_PRIORITIES.md` — qué hacer ahora.
2. Lee `ARCHITECTURE_OVERVIEW.md` — cómo está estructurado.
3. Lee `CONVENTIONS.md` — cómo escribir código.

### Setup local
```bash
fvm install
fvm flutter pub get
cd ios && pod install --repo-update && cd ..
fvm flutter run
```

---

## 📋 Índice completo

### 🎯 Estrategia y MVP
| Documento                                          | Descripción                                       |
|----------------------------------------------------|---------------------------------------------------|
| [`MVP_ANALYSIS.md`](./MVP_ANALYSIS.md)             | Análisis completo del estado actual               |
| [`MVP_PRIORITIES.md`](./MVP_PRIORITIES.md)         | Top 5 prioridades inmediatas                      |
| [`MVP_ROADMAP.md`](./MVP_ROADMAP.md)               | Timeline detallado para lanzamiento               |
| [`TECHNICAL_DEBT.md`](./TECHNICAL_DEBT.md)         | Deuda técnica identificada                        |

### 🏗️ Arquitectura y código
| Documento                                          | Descripción                                       |
|----------------------------------------------------|---------------------------------------------------|
| [`ARCHITECTURE_OVERVIEW.md`](./ARCHITECTURE_OVERVIEW.md) | Visión general de la arquitectura            |
| [`CONVENTIONS.md`](./CONVENTIONS.md)               | Convenciones detalladas de código                 |
| [`TDD_GUIDE.md`](./TDD_GUIDE.md)                   | Guía operativa de TDD del proyecto                |

### 🤖 Sistema agéntico
| Documento                                                  | Descripción                                   |
|------------------------------------------------------------|-----------------------------------------------|
| [`/CLAUDE.md`](../CLAUDE.md)                               | Guía maestra para Claude                      |
| [`AGENTIC_DEVELOPMENT.md`](./AGENTIC_DEVELOPMENT.md)       | Sistema agéntico (agentes, comandos, flujos)  |
| [`/.claude/README.md`](../.claude/README.md)               | Configuración de agentes y comandos           |

### 📜 Historial
| Documento                                          | Descripción                                       |
|----------------------------------------------------|---------------------------------------------------|
| [`CHANGELOG.md`](./CHANGELOG.md)                   | Historial de cambios                              |
| [`features/`](./features/)                         | Documentación por feature                         |
| [`decisions/`](./decisions/)                       | ADRs (Architecture Decision Records)              |

---

## 🎯 Resumen ejecutivo

### Estado actual del MVP
- ✅ **~85%** de funcionalidades core implementadas
- ✅ Sistema de tema (claro/oscuro) persistente
- ✅ Internacionalización ES/EN completa
- ✅ Onboarding multi-página
- ✅ Sistema agéntico de desarrollo configurado
- ⚠️ Falta: recuperación de contraseña, manejo de errores de conexión global
- 🧹 Pendiente: limpieza de `print()` y auditoría de anti-patrones

### Prioridades inmediatas (ver `MVP_PRIORITIES.md`)
1. 🔒 Recuperación de contraseña (UI)
2. 🔌 Widget global de errores de conexión
3. 🧹 Limpieza de logs de debug
4. 🧪 Aumentar cobertura de tests a ≥ 80%
5. 📱 QA en dispositivos reales

### Timeline de lanzamiento
- **Sprint 1 (Semana 1):** Estabilización con `/review` por feature.
- **Sprint 2 (Semana 2):** Features faltantes con `/plan` → `/tdd` → `/doc`.
- **Sprint 3 (Semana 3):** Pulido y QA en dispositivos.
- **Sprint 4 (Semana 4):** Lanzamiento en stores.

---

## 🤖 Workflow de desarrollo recomendado

### Para una nueva feature
```
1. /plan "Quiero añadir <feature>"
   ↓ Planner genera doc/features/<feature>.md

2. (revisar y aprobar el plan)

3. /tdd
   ↓ Tester escribe los 3+ tests obligatorios
   ↓ Implementer hace pasar los tests
   ↓ Implementer refactoriza

4. /doc
   ↓ Documenter actualiza doc/

5. /review
   ↓ 🟢 LISTA PARA MERGE

6. git commit -m "feat(<scope>): ..."
```

Ver `AGENTIC_DEVELOPMENT.md` para detalles completos.

### Para un bug fix
```
1. /test reproduce "<descripción del bug>"
   ↓ Tester escribe test que falla mostrando el bug

2. /implement fix
   ↓ Implementer hace el fix mínimo

3. /doc
   ↓ Entry en CHANGELOG sección Fixed

4. git commit -m "fix(<scope>): ..."
```

---

## 📊 Métricas actuales del proyecto

| Métrica                      | Valor estimado     |
|------------------------------|--------------------|
| Líneas de código (lib/)      | ~15,000            |
| Features completas           | 9 de 10            |
| Cobertura de tests           | ~15% (objetivo: 80%)|
| Cubits implementados         | ~15                |
| Use cases                    | ~25                |
| Screens                      | ~20                |
| Claves i18n                  | 300+ (ES/EN)       |
| Dependencias                 | 45+                |

---

## 🔧 Stack técnico

### Core
- **Flutter** 3.32.7 (gestionado por FVM)
- **Dart** 3.7+
- **Bloc** 9.0.0 + `flutter_bloc` 9.1.0 + `hydrated_bloc` 10.1.1
- **Freezed** 3.0.3 (sealed classes)
- **GetIt** 8.0.3 (DI)
- **auto_route** 9.2.2

### Backend
- **Firebase** (Auth, Firestore, Messaging, Storage)
- **Supabase** (planificado para staging/prod)
- **Turbo_Core** (package compartido vía Git)

### Diseño
- **`turbo_ui`** — package local con design system propio.

### Testing
- **flutter_test** + **bloc_test** 10.0.0 + **mocktail** 1.0.0

---

## 📞 Repositorios relacionados

- **Turbo_App** — App móvil (este repo).
- **Turbo-Admin** — Web admin para negocios.
- **Turbo_Core** — Package Dart con repositorios y modelos.

---

**Mantra del proyecto:** *Plan first, test first, ship after review.*
