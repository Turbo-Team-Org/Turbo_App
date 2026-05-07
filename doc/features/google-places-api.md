# Feature Plan: google-places-api

## Objetivo
Completar la integracion de Google Places para el flujo de ubicaciones con enfoque Core-first, eliminando stubs en `Turbo_Core` y conectando `Turbo-Admin` para autocompletado y seleccion de direccion sin llamadas HTTP directas en la UI.

## Contexto actual verificado
- `Turbo_Core/core/lib/src/turbo_core_repositories/location_repository/service/location_service_supabase.dart` mantiene stubs en:
  - `searchPlaces()`
  - `getPlaceDetails()`
  - `autocompletePlaces()`
  - `searchNearbyPlaces()`
  - `geocodeAddress()`
- `Turbo_Core/core/lib/src/turbo_core_repositories/location_repository/service/location_service.dart` (Firebase) ya tiene implementacion real contra Google Places y se usara como referencia funcional.
- `Turbo-Admin/lib/features/places/pages/place_form_page.dart` realiza llamadas HTTP directas a Google Places y tiene API key hardcodeada en la UI.

## Alcance (in)
1. Implementar Google Places en `LocationServiceSupabase` (Core).
2. Tipar errores de ubicacion en Core para evitar `Exception` generica.
3. Exponer configuracion de API key por entorno (sin hardcode).
4. Migrar `Turbo-Admin` para usar repositorio/cubit en lugar de llamadas HTTP directas en `place_form_page.dart`.
5. Agregar pruebas RED->GREEN en Core y Admin para endpoints y UX principal de autocompletado.

## Fuera de alcance (out)
- Refactor completo del modulo de mapas en Admin.
- Cambios de UX grandes fuera de autocompletado + seleccion.
- Migracion de App movil en este ticket (solo Core + Admin segun Sprint 2 T1).

## Arquitectura propuesta (Clean + Core-first)

### Capa Core (Turbo_Core)
- **Data service**: implementar `LocationServiceSupabase` con cliente HTTP reutilizable.
- **Error model**: crear `LocationException` (codigos: network, unauthorized, rate_limit, invalid_request, upstream, unknown).
- **Config**: agregar getter en `Env` para `GOOGLE_MAPS_API_KEY`.
- **Repository**: `LocationRepository` ya enruta por interfaz, mantener API publica.

### Capa Admin (Turbo-Admin)
- **Presentation/state**: mover logica de autocompletado y seleccion al `PlaceFormCubit`.
- **UI**: `PlaceFormPage` solo renderiza y delega eventos.
- **Debounce**: mantener debounce de entrada en cubit/handler para no saturar API.

## Archivos a crear

### Turbo_Core
- `core/lib/src/turbo_core_repositories/location_repository/exceptions/location_exception.dart`
- `core/test/src/turbo_core_repositories/location_repository/service/location_service_supabase_test.dart`

### Turbo-Admin
- `test/features/places/cubit/place_form_cubit_google_places_test.dart`
- `test/features/places/pages/place_form_page_autocomplete_test.dart`

## Archivos a modificar

### Turbo_Core
- `core/lib/src/turbo_core_repositories/location_repository/service/location_service_supabase.dart`
- `core/lib/src/monorepo_utils/environments.dart`
- `core/env.example`
- `core/.env_no_rls`
- `core/.env_with_rls`

### Turbo-Admin
- `lib/features/places/cubit/place_form_cubit.dart`
- `lib/features/places/cubit/place_form_state.dart`
- `lib/features/places/pages/place_form_page.dart`

## Plan de implementacion por fases

### Fase 1 - RED (tests en Core)
1. Crear tests para `LocationServiceSupabase` con mock HTTP client:
   - `searchPlaces` mapea `results` a `GooglePlace`.
   - `getPlaceDetails` mapea `result`.
   - `autocompletePlaces` usa `predictions` + resolucion de detalles.
   - errores HTTP/timeouts -> `LocationException`.
2. Confirmar fallos iniciales (RED).

### Fase 2 - GREEN (Core)
1. Implementar helper interno de request + parse de estado Google (`OK`, `ZERO_RESULTS`, `OVER_QUERY_LIMIT`, etc.).
2. Implementar metodos:
   - `searchPlaces`
   - `getPlaceDetails`
   - `autocompletePlaces`
   - `searchNearbyPlaces`
   - `geocodeAddress`
3. Añadir `Env.googleMapsApiKey`.
4. Validar que si falta API key se lanza `LocationException.invalidRequest`.

### Fase 3 - RED/GREEN (Admin)
1. Introducir en `PlaceFormCubit` acciones para:
   - `onAddressInputChanged(String input)` con debounce.
   - `selectAutocompletePlace(String placeId)`.
2. Actualizar estado para exponer:
   - `autocompleteSuggestions`
   - `isAutocompleteLoading`
   - `autocompleteError`
3. Refactor de `PlaceFormPage`:
   - eliminar llamadas HTTP directas y API key hardcodeada.
   - bindear UI a estado del cubit.
4. Tests de cubit y widget para flujo de sugerencias y seleccion.

### Fase 4 - Verificacion
1. `dart analyze` en Core y Admin.
2. `flutter test`/`dart test` de los nuevos casos.
3. Smoke manual: crear/editar lugar en Admin con sugerencias reales.

## Tests obligatorios (minimo 3, propuestos 6)
1. `location_service_supabase_test`: `searchPlaces` exitoso retorna lista con campos mapeados.
2. `location_service_supabase_test`: `getPlaceDetails` exitoso retorna `GooglePlace`.
3. `location_service_supabase_test`: `autocompletePlaces` retorna maximo esperado y resuelve detalles.
4. `location_service_supabase_test`: timeout/4xx/5xx lanza `LocationException` tipada.
5. `place_form_cubit_google_places_test`: debounce + carga de sugerencias.
6. `place_form_page_autocomplete_test`: al seleccionar sugerencia se actualizan direccion y coordenadas.

## Riesgos y mitigaciones
- **Cuotas/rate limit Google Places**: manejar `OVER_QUERY_LIMIT` y mostrar feedback amigable.
- **Latencia en autocomplete**: debounce (300-500ms) + cancelacion de requests previas.
- **Regresion en formulario Admin**: tests widget + fallback visual en error.
- **Configuracion incompleta en entornos**: validar `GOOGLE_MAPS_API_KEY` al inicio del flujo.
- **Acoplamiento UI-data**: mantener llamadas en cubit/use-case, no en widget.

## Estimacion de esfuerzo
- Core (servicio + excepciones + tests): **1.0 dia**
- Admin (refactor cubit/page + tests): **0.75 dia**
- Verificacion/analyze/manual QA: **0.25 dia**
- **Total:** ~**2 dias** (alineado a Sprint 2 T1)

## Criterios de aceptacion
- `searchPlaces("Restaurante La Habana")` devuelve `List<GooglePlace>` no vacia cuando API responde OK.
- `getPlaceDetails(placeId)` retorna direccion formateada y coordenadas.
- `geocodeAddress("Obispo 123, La Habana")` retorna `LocationData`.
- En Admin, al escribir direccion aparecen sugerencias y al seleccionar se actualizan direccion + lat/lng.
- Errores de red/API se tipan como `LocationException` y se muestran mensajes controlados.

## Handoff para /tdd
- Empezar por `Turbo_Core` (RED->GREEN).
- Luego integrar `Turbo-Admin` sobre API del repositorio ya estable.
- Ejecutar verify final antes de abrir PR hacia `develop`.
