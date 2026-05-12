# 📜 Changelog — Turbo App

> Formato basado en [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).  
> Versionado: [Semantic Versioning](https://semver.org/lang/es/).

---

## [Unreleased]

### Added
- **Sistema agéntico de desarrollo** (`/.claude/`):
  - 4 agentes especializados: Planner, Tester, Implementer, Documenter.
  - 7 comandos invocables: `/plan`, `/tdd`, `/test`, `/implement`, `/doc`, `/feature`, `/review`.
  - 4 workflows estandarizados: feature, TDD, bugfix, MVP.
  - Plantillas reutilizables para Cubits, States, Use Cases, Tests y Screens.
- **`CLAUDE.md`** — guía maestra del proyecto con arquitectura, patrones y reglas.
- **`doc/AGENTIC_DEVELOPMENT.md`** — documentación del sistema agéntico.
- **`doc/TDD_GUIDE.md`** — guía operativa de TDD del proyecto.
- **`doc/CONVENTIONS.md`** — convenciones detalladas de código.
- **S2-T2 `search-filters` (hardening de calidad):**
  - tests adicionales de cubit para combinaciones y edge-cases de `applyFilters`
  - tests de módulo para `SearchPlacesUseCase` / `SearchPlacesByVoiceUseCase` / `SearchPlacesByLocationUseCase`
  - limpieza de null-checks/casts redundantes en `PlacesSearchCubit`

### Changed
- `places_search_screen.dart` elimina pantalla temporal de test de Google Maps (debug-only) para evitar literales fuera de l10n.

### Fixed
- warnings de analyze en `places_search_cubit.dart` relacionados a `null-aware`, `!` innecesario y `switch default` redundante.

### Removed

---

## [0.9.0] — 2026-01-26

### Added
- **Onboarding** multi-página con animaciones, indicador y persistencia.
- **Internacionalización ES/EN** completa (300+ claves).
- **Theme selector** con `HydratedBloc` para persistencia.
- **`turbo_ui` package** — sistema de diseño premium (colores, tipografía, spacing, shadows, themes light/dark).

### Changed
- `feed_screen.dart` refactorizado de ~1700 → ~200 líneas (extracción de widgets).
- Migración a `freezed sealed class` para States.
- Migración a `withValues(alpha:)` desde `withOpacity`.
- Migración a `auto_route 9.2.2` (incompatibilidad con `kTransitionMilliseconds` en 10.x).

### Fixed
- Conflicto persistente de versiones de `intl` con `flutter_localizations`.
- Build iOS por error `kTransitionMilliseconds`.
- Render overflow en `welcome_section.dart`.
- Dark mode no aplicado en feed body.
- CocoaPods UTF-8 encoding error.

### Technical
- Setup base con Clean Architecture: Domain (use cases) → Data (core package) → Presentation (cubits + UI).
- Dependency Injection con GetIt.
- Routing con auto_route + AuthGuard.
- Estructura de tests con bloc_test + mocktail.

---

## [Pre-0.9.0]

> Versiones anteriores: setup inicial del proyecto con autenticación (Email + Google), feed de places, detalles, reservaciones, eventos, favoritos, reseñas y categorías.

---

## Convenciones para añadir entradas

Tras cada feature, añadir entrada en **Unreleased** con uno de:

- **Added**: nuevas features.
- **Changed**: cambios en features existentes.
- **Deprecated**: features que serán removidas.
- **Removed**: features eliminadas.
- **Fixed**: bug fixes.
- **Security**: parches de seguridad.

**Ejemplo:**
```markdown
## [Unreleased]

### Added
- `forgot_password_screen` con flujo completo de recuperación (#42).

### Fixed
- Counter de favoritos no se decrementaba al quitar (#38).
```

Al hacer release, mover de **Unreleased** a `## [X.Y.Z] — YYYY-MM-DD`.
