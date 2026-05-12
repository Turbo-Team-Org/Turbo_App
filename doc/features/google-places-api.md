# Feature Plan: google-places-api (cierre S2-T1)

## Objetivo
Cerrar los pendientes de Sprint 2 T1 enfocados en UX final de autocompletado en `Turbo-Admin`, validacion manual en staging y verificacion final de calidad con `/review`.

## Contexto de entrada (segun SPRINT_2)
- Core de Google Places ya esta implementado y probado.
- Hardening inicial en Admin ya esta aplicado.
- Pendientes activos:
  1. Integrar flujo end-to-end de autocompletado desde Cubit/Repository en `PlaceFormPage`.
  2. Ejecutar QA manual con API key real en staging.
  3. Ejecutar `/review` final y marcar DoD de S2-T1.

## Alcance de este plan (in)
1. Completar integracion UI + estado para sugerencias y seleccion de direccion en `PlaceFormPage`.
2. Cubrir el flujo con tests RED->GREEN en cubit/widget del modulo `places`.
3. Definir protocolo QA manual con criterios verificables en staging.
4. Cerrar con evidencia de `/review` y decision de DoD.

## Fuera de alcance (out)
- Reescribir el modulo de places completo.
- Cambios de producto fuera del formulario de direccion.
- Nuevos endpoints o cambios estructurales en Core si no son estrictamente necesarios para el flujo.

## Arquitectura objetivo (feature-first + Clean)

### Turbo-Admin (principal)
- `cubit`: orquesta entrada de texto, debounce, carga de sugerencias, seleccion de item, y propagacion a campos del form.
- `pages`: `PlaceFormPage` solo renderiza estados y despacha eventos al cubit.
- `widgets` (si aplica): extraer lista de sugerencias para mantener pagina limpia y testeable.

### Turbo_Core (sin cambios mayores esperados)
- Consumir `LocationRepository` ya integrado (sin HTTP directo en UI).
- Mantener errores tipados para feedback controlado en estado/UI.

## Archivos a modificar (estimados)
- `Turbo-Admin/lib/features/places/cubit/place_form_cubit.dart`
- `Turbo-Admin/lib/features/places/cubit/place_form_state.dart`
- `Turbo-Admin/lib/features/places/pages/place_form_page.dart`

## Archivos a crear (si faltan)
- `Turbo-Admin/test/features/places/cubit/place_form_cubit_google_places_test.dart`
- `Turbo-Admin/test/features/places/pages/place_form_page_autocomplete_test.dart`

## Plan de ejecucion (RED -> GREEN -> REFACTOR)

### Fase 1 - RED (tests obligatorios)
1. Test cubit: al escribir direccion (con debounce) dispara carga de sugerencias y emite estado de loading->success.
2. Test cubit: al seleccionar sugerencia se cargan direccion final y coordenadas en el estado.
3. Test cubit: error del repositorio produce estado de error controlado (sin crash).
4. Test widget: `PlaceFormPage` muestra sugerencias y permite seleccionarlas.

### Fase 2 - GREEN (implementacion minima)
1. Implementar/ajustar handlers en `PlaceFormCubit`:
   - `onAddressInputChanged(String value)`
   - `onAddressSuggestionSelected(...)`
2. Garantizar debounce y descarte de requests obsoletos.
3. Vincular `PlaceFormPage` al estado del cubit para:
   - Render de lista de sugerencias
   - Tap en sugerencia
   - Actualizacion de direccion/lat/lng en formulario
4. Mantener toda llamada a Places via Core repository (sin hardcode ni HTTP en UI).

### Fase 3 - REFACTOR + QA
1. Limpieza de estado y mensajes de error para UX consistente.
2. QA manual en staging con key real:
   - Escribir direccion parcial -> aparecen sugerencias relevantes.
   - Seleccionar sugerencia -> campos direccion + coordenadas se completan.
   - Simular error de red -> feedback visible y flujo recuperable.
3. Ejecutar `/review` final y adjuntar evidencia.

## Estimacion de esfuerzo
- Integracion cubit/page: **0.5 dia**
- Tests RED/GREEN + ajustes: **0.5 dia**
- QA manual + `/review`: **0.25 dia**
- **Total estimado:** **1.25 dias**

## Riesgos y mitigaciones
- **Race conditions por tecleo rapido** -> debounce + invalidacion de respuesta vieja.
- **Cuotas/rate limit** -> mapear error y mostrar mensaje no bloqueante.
- **Regresion en form** -> test widget de seleccion + smoke manual en alta/edicion.
- **Datos inconsistentes (direccion sin coords)** -> validar seleccion atomica (direccion + lat/lng).

## Definition of Done (S2-T1)
- [ ] Autocompletado end-to-end operativo desde `PlaceFormCubit`/`LocationRepository` en `PlaceFormPage`.
- [ ] Tests nuevos/ajustados en verde para cubit y pagina.
- [ ] QA staging completado con evidencia.
- [ ] `/review` final en estado APTO.
- [ ] S2-T1 marcado como cerrado en `SPRINT_2.md`.

## Handoff propuesto para /tdd
- Empezar por RED en `Turbo-Admin/test/features/places/...`.
- Implementar GREEN en `cubit` y `page` sin tocar Core salvo bloqueo puntual.
- Cerrar con REFACTOR, QA manual y `/review` final.
