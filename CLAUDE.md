# Turbo_App — CLAUDE.md (App móvil Flutter)

> Subproyecto: app móvil para usuarios finales de Turbo (Yelp Cuba).
> **Hereda de:** [`/CLAUDE.md`](../CLAUDE.md) (workspace).
> Este archivo solo describe lo único de este subproyecto.

---

## 1. Responsabilidad end-to-end del subproyecto

**Turbo_App** es la app móvil que ven los **usuarios finales**. Su responsabilidad es:

1. **Descubrimiento:** explorar lugares, eventos, categorías y favoritos.
2. **Búsqueda:** buscar lugares con filtros (categoría, rating, distancia, abierto ahora).
3. **Reservación:** flujo de booking; **en el MVP la reserva es gratuita** (confirmación directa sin checkout). Integración de pago (TropiPay) queda **Post-MVP**.
4. **Reviews:** leer y publicar reseñas con estrellas y texto.
5. **Perfil:** gestión de cuenta, foto, historial.
6. **Asistente IA:** chat conversacional para recomendaciones (próximo).
7. **Notificaciones push:** alertas de reservas, reviews, eventos.

**Lo que NUNCA debe hacer este subproyecto:**
- ❌ Llamar a Supabase/Firebase directamente. Todo va vía `Turbo_Core`.
- ❌ Tener lógica de negocio en widgets. Va en cubits/use cases.
- ❌ Reimplementar lo que ya está en `turbo_ui` o `core`.
- ❌ Importar `mock_data/` desde `lib/` (solo en `test/fixtures/`).

---

## 2. Estructura OBLIGATORIA por feature

```
lib/<feature>/
├── module/                                # Domain Layer (use cases)
│   ├── <action>_use_case.dart
│   ├── <feature>_module.dart              # barrel
│   └── use_case_params_models/            # opcional
│
├── presentation/                          # Presentation Layer (UI)
│   ├── screens/
│   │   └── <feature>_screen.dart
│   └── widgets/
│       └── <widget_name>.dart
│
└── state_management/                      # Presentation Layer (Estado)
    └── <feature>_cubit/
        └── cubit/                         # ← carpeta anidada (convención del proyecto)
            ├── <feature>_cubit.dart
            ├── <feature>_state.dart       # part of cubit, freezed sealed
            └── <feature>_cubit.freezed.dart
```

> ⚠️ Los Cubits viven en `state_management/<n>_cubit/cubit/` (carpeta `cubit/` anidada).

---

## 3. Patrones específicos de la App

### 3.1 Use Case

```dart
import 'package:core/core.dart';
import 'package:turbo/app/core/no_params.dart';
import 'package:turbo/app/core/use_case.dart';

class GetPlacesUseCase implements UseCase<Future<List<Place>>, NoParams> {
  final PlaceRepository placeRepository;
  GetPlacesUseCase({required this.placeRepository});

  @override
  Future<List<Place>> call(NoParams param) async =>
      await placeRepository.getPlaces();
}
```

**Reglas:**
- Implementa `UseCase<ReturnType, ParamsType>`.
- Sin params → `NoParams` (de `app/core/no_params.dart`).
- Una sola responsabilidad por use case.

### 3.2 Cubit + State

```dart
// place_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:turbo/app/core/no_params.dart';
import 'package:turbo/places/module/get_places_use_case.dart';
import 'package:core/core.dart';

part 'place_state.dart';
part 'place_cubit.freezed.dart';

class PlaceCubit extends Cubit<PlaceState> {
  final GetPlacesUseCase getPlacesUseCase;
  PlaceCubit({required this.getPlacesUseCase})
      : super(const PlaceState.initial());

  Future<void> getPlaces() async {
    emit(const PlacesLoading());
    try {
      final places = await getPlacesUseCase.call(NoParams());
      emit(PlaceState.loaded(places: places));
    } catch (e) {
      emit(PlacesError(e.toString()));
    }
  }
}
```

```dart
// place_state.dart
part of 'place_cubit.dart';

@freezed
sealed class PlaceState with _$PlaceState {
  const factory PlaceState.initial() = PlacesInitial;
  const factory PlaceState.loading() = PlacesLoading;
  const factory PlaceState.loaded({required List<Place> places}) = PlacesLoaded;
  const factory PlaceState.error(String error) = PlacesError;
}
```

### 3.3 Dependency Injection (GetIt)

Toda dependencia se registra en `lib/app/dependency_injection/init_config.dart`.

**Orden:** Service/Repository → Use Cases → Cubits.

```dart
sl
  ..registerLazySingleton<GetPlacesUseCase>(
    () => GetPlacesUseCase(placeRepository: sl<PlaceRepository>()),
  )
  ..registerLazySingleton<PlaceCubit>(
    () => PlaceCubit(getPlacesUseCase: sl<GetPlacesUseCase>()),
  );
```

- `registerLazySingleton` → cubits compartidos
- `registerFactory` → instancia nueva por pantalla

### 3.4 Routing — `auto_route 9.2.2`

> **NO actualizar a 10.x** — incompatible con `kTransitionMilliseconds`.

```dart
@RoutePage()
class FeatureScreen extends StatelessWidget { ... }

// app_router.dart
AutoRoute(page: FeatureRoute.page, path: '/feature'),

// Tras añadir ruta:
dart run build_runner build --delete-conflicting-outputs
```

**Navegación:**
- ✅ `context.router.push(FeatureRoute())`
- ✅ `context.router.maybePop()`
- ❌ `context.router.pop()`
- ❌ `context.router.pushPath('/x')`

### 3.5 Localización (i18n) — OBLIGATORIO

**Toda string visible al usuario** se internacionaliza. Idiomas: **es** (default), **en**.

**Pasos:**
1. Añadir clave a ambos ARBs: `lib/app/l10n/arb/app_es.arb` y `app_en.arb`.
2. Ejecutar `fvm flutter gen-l10n`.
3. Usar: `context.l10n.miClave`.

**Prohibido:**
- ❌ `Text('Hola')` literal
- ❌ `const InputDecoration(labelText: 'Email')` con literal

### 3.6 Theming — `turbo_ui`

```dart
// ✅ Bien
color: TurboColors.primary
TurboColors.primary.withValues(alpha: 0.5)

// ❌ Mal
color: Color(0xFFFF003D)
color: Colors.red
.withOpacity(0.5)
```

**Tokens:** `TurboColors`, `TurboTypography`, `TurboSpacing`, `TurboRadius`, `TurboShadows`, `TurboDurations`, `TurboButtonStyles`, `TurboCardStyles`, `TurboInputStyles`.

---

## 4. Anti-patrones específicos de Flutter (resumen)

| ❌ Prohibido | ✅ Hacer |
|---|---|
| `print('debug...')` | `debugPrint('...')` o `AppLogger.debug()` |
| `Text('Texto')` literal | `Text(context.l10n.clave)` |
| `Color(0xFFFF003D)` | `TurboColors.primary` |
| `.withOpacity(0.5)` | `.withValues(alpha: 0.5)` |
| `context.router.pop()` | `context.router.maybePop()` |
| `context.router.pushPath('/x')` | `context.router.push(XRoute())` |
| Cubit sin tests | Cubit con ≥3 tests |
| State sin freezed sealed | `@freezed sealed class State` |
| DI implícita / Singletons globales | Registro en `init_config.dart` + `sl<T>()` |
| Archivos > 500 líneas | Extraer widgets/helpers |
| Lógica de negocio en `build()` | Lógica en Cubit / Use Case |
| `flutter` global | `fvm flutter` (versión pinneada en `.fvmrc`) |

---

## 5. Decisiones técnicas pinned

| Decisión | Razón | NO cambiar sin |
|---|---|---|
| `auto_route ^9.2.2` | Incompatibilidad con `kTransitionMilliseconds` | Discusión + ADR |
| `freezed: ^3.0.3` | Soporte para `sealed class` | ADR |
| `bloc ^9.0.0` + `hydrated_bloc ^10.1.1` | Versiones compatibles entre sí | ADR |
| Cubits en lugar de Blocs (con events) | Menor boilerplate, suficiente para CRUD | Discusión |
| GetIt + factory/lazySingleton | Convención del proyecto desde inicio | Discusión |
| `core` package por Git ref | Compartir lógica con admin panel | — |
| `fvm flutter` (NO global) | Versión pinneada para todos los devs | — |

---

## 6. Comandos de desarrollo

```bash
# Setup
fvm flutter pub get
cd ios && pod install --repo-update && cd ..

# Code generation
fvm dart run build_runner build --delete-conflicting-outputs

# Localización
fvm flutter gen-l10n

# Run
fvm flutter run

# Tests
fvm flutter test
fvm flutter test --coverage
genhtml coverage/lcov.info -o coverage/html

# Lint
fvm flutter analyze
```

---

## 7. Estado de features (resumen — ver sprints para detalle)

| Feature | Estado |
|---|---|
| Reviews UI | ✅ Implementado (`lib/reviews/presentation/`) — pendiente verificación |
| Profile screen | ✅ Sin `mock_data`; próximo paso S1-T2 `profile-complete` |
| Payments / checkout | ⏸️ Post-MVP (`payment_repository` existe en Core; sin UI en App en MVP) |
| Notifications | ⚠️ Usa `cloud_firestore` (debe migrar a Supabase) |
| Mock data | ⚠️ Existe en `lib/` (debe moverse a `test/fixtures/`) |
| Search filters | ❌ Sin filtros |
| Edit profile | ❌ No existe |
| AI chat UI | ❌ `lib/ai_chat/` no existe (Core completo) |

Roadmap detallado: [`/.claude/sprints/`](../.claude/sprints/).

---

## 8. Referencias

- **Workspace** (paraguas): [`/CLAUDE.md`](../CLAUDE.md)
- **Sistema agéntico:** [`/.claude/`](../.claude/)
- **Sprints:** [`/.claude/sprints/`](../.claude/sprints/)
- **Templates Dart:** [`/.claude/templates/`](../.claude/templates/)
- **Workflows:** [`/.claude/workflows/`](../.claude/workflows/)
- **Doc del subproyecto:** `Turbo_App/doc/` (si existe)
