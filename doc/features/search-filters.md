# Feature Plan: search-filters (S2-T2)

## Objetivo
Completar filtros avanzados en búsqueda de lugares en `Turbo_App` con arquitectura Clean (domain + state + presentation), usando la base existente de `PlacesSearchCubit` y terminando la experiencia de usuario en `PlacesSearchScreen`.

## Estado real verificado (codebase)
- Ya existe `PlacesSearchCubit` con soporte de filtros:
  - `updateFilters(...)`
  - `updateAdvancedFilters(...)`
  - `clearFilters()`
  - `showOnlyOpenNow`, `minRating`, `maxDistance`, `sortBy`, etc.
- Ya existen params con filtros en domain:
  - `SearchPlacesParams`
  - `GetPlacesByLocationParams`
- `PlacesSearchScreen` tiene botón de filtros pero el bottom sheet está en placeholder:
  - texto `Filtros próximamente...`
- No hay tests de `places_search_cubit` ni widget tests de filtros.

## Alcance (in)
1. Implementar UI de filtros (bottom sheet) y conexión real al cubit.
2. Mostrar chips de filtros activos bajo la barra de búsqueda.
3. Añadir acción de limpiar filtros completa.
4. Asegurar estado vacío con mensaje específico para filtros.
5. Agregar tests RED->GREEN de cubit y widgets.

## Fuera de alcance (out)
- Rediseño total de `PlacesSearchScreen`.
- Ranking complejo por IA/relevancia.
- Cambios en backend Core para nuevos campos que no estén ya disponibles.

## Arquitectura propuesta

### Domain (`lib/places/module`)
- Reutilizar `SearchPlacesParams` y `GetPlacesByLocationParams` existentes.
- Agregar un modelo liviano de UI params para filtros si hace falta desacoplar la vista:
  - `lib/places/module/params/search_filters_params.dart` (`@freezed`)

### State (`lib/places/state_management/place_search_cubit`)
- Mantener `PlacesSearchCubit` como orquestador.
- Añadir método explícito de alto nivel para UI:
  - `applyFilters(SearchFiltersParams params)` (wrapper de `updateFilters` + `updateAdvancedFilters`)
- Normalizar mensajes para estado vacío por filtros.

### Presentation (`lib/places/presentation`)
- Crear `SearchFiltersSheet` reusable.
- Integrarlo desde `PlacesSearchScreen._showFiltersBottomSheet()`.
- Renderizar chips activos (`rating`, `abierto ahora`, `sort`, `categoría`) y botón `Limpiar`.
- Todas las labels por `context.l10n` (sin strings hardcodeados nuevos).

## Archivos a crear
- `lib/places/module/params/search_filters_params.dart`
- `lib/places/module/params/search_filters_params.freezed.dart` (generado)
- `lib/places/module/params/search_filters_params.g.dart` (generado, si aplica json)
- `lib/places/presentation/widgets/search_filters_sheet.dart`
- `test/places/cubit/places_search_cubit_filters_test.dart`
- `test/places/presentation/search_filters_sheet_test.dart`
- `test/places/presentation/places_search_screen_filters_test.dart`

## Archivos a modificar
- `lib/places/state_management/place_search_cubit/places_search_cubit.dart`
- `lib/places/state_management/place_search_cubit/places_search_state.dart` (si añadimos flags auxiliares)
- `lib/places/presentation/screens/places_search_screen.dart`
- `lib/places/presentation/widgets/places_search_bar.dart` (si hay que inyectar estado de filtros activos)
- `lib/app/l10n/arb/app_es.arb`
- `lib/app/l10n/arb/app_en.arb`
- `lib/app/l10n/generated/*` (regenerado)

## Plan de implementación (TDD)

### Fase 1 — RED (tests)
1. `places_search_cubit_filters_test.dart`
   - estado inicial de filtros.
   - aplicar filtros actualiza estado y dispara carga.
   - `clearFilters` vuelve a defaults.
2. `search_filters_sheet_test.dart`
   - render de controles (rating, abierto, sort).
   - callback de aplicar y limpiar.
3. `places_search_screen_filters_test.dart`
   - abre bottom sheet.
   - aplica filtros y aparecen chips activos.
   - con 0 resultados muestra mensaje orientado a filtros.

### Fase 2 — GREEN (implementación mínima)
1. Implementar `SearchFiltersSheet`.
2. Integrar `applyFilters`/`clearFilters` en cubit.
3. Conectar `PlacesSearchScreen` con el sheet y chips activos.
4. Añadir strings i18n necesarias.

### Fase 3 — REFACTOR
1. Reducir complejidad de `places_search_screen.dart` extrayendo widgets privados.
2. Garantizar Stateless widgets para piezas de UI reutilizables.
3. Revisar accesibilidad:
   - labels semánticos en sliders/toggles
   - targets táctiles mínimos
   - contraste de chips

### Fase 4 — Verificación
1. `fvm flutter test test/places/...`
2. `fvm flutter analyze`
3. QA manual en búsqueda:
   - filtros combinados
   - limpiar filtros
   - persistencia durante sesión de pantalla

## Tests obligatorios (mínimo 3, propuestos 7)
1. Cubit: initial filters defaults.
2. Cubit: applyFilters actualiza state.
3. Cubit: clearFilters restaura defaults.
4. Widget: SearchFiltersSheet muestra controles.
5. Widget: botón aplicar dispara callback.
6. Widget: botón limpiar resetea controles.
7. Screen: chips activos y mensaje de no resultados por filtro.

## Riesgos y mitigaciones
- **Riesgo:** archivo `places_search_screen.dart` muy grande.
  - **Mitigación:** extraer `SearchFiltersSheet` y `ActiveFiltersChips`.
- **Riesgo:** duplicación de lógica entre `updateFilters` y `updateAdvancedFilters`.
  - **Mitigación:** introducir `applyFilters(params)` consolidado.
- **Riesgo:** regresiones en mapa/lista al cambiar estado.
  - **Mitigación:** tests widget + validación de panel/mapa.

## Estimación
- RED tests: 0.75d
- GREEN implementación: 1.5d
- REFACTOR + QA: 0.75d
- Total: ~3 días (alineado a Sprint 2 T2)

## Criterios de aceptación
- Filtros por categoría, rating mínimo, abierto ahora y ordenar funcionan.
- Chips de filtros activos visibles bajo barra de búsqueda.
- `Limpiar filtros` restaura estado base.
- Resultados se refrescan tras aplicar filtros.
- Mensaje contextual cuando no hay resultados por filtros.
