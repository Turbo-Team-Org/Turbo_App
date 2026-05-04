# 📐 Convenciones de Código — Turbo App

> Convenciones detalladas que TODA contribución debe respetar.  
> Este documento expande lo descrito en `CLAUDE.md` § 2 y 3.

---

## 📁 1. Convención de carpetas por feature

Toda feature en `lib/<feature>/` DEBE seguir EXACTAMENTE esta estructura:

```
lib/<feature>/
├── module/                              # Domain Layer (Use Cases)
│   ├── <action>_use_case.dart
│   └── use_case_params_models/          # (opcional) Si los params son complejos
│
├── presentation/                         # Presentation Layer - UI
│   ├── screens/
│   │   └── <feature>_screen.dart
│   └── widgets/
│       └── <widget>.dart
│
└── state_management/                     # Presentation Layer - Estado
    └── <feature>_cubit/                  # ← carpeta
        └── cubit/                        # ← subcarpeta (convención del proyecto)
            ├── <feature>_cubit.dart
            ├── <feature>_state.dart
            └── <feature>_cubit.freezed.dart  # ← generado
```

### ⚠️ La doble carpeta `<feature>_cubit/cubit/`

Es intencional. Ejemplos verificados:
- `lib/places/state_management/place_bloc/cubit/place_cubit.dart`
- `lib/authentication/state_management/auth_cubit/cubit/auth_cubit_cubit.dart`
- `lib/favorites/state_management/cubit/favorite_cubit.dart` (excepción simplificada)

---

## 🏷️ 2. Naming Conventions

### Archivos
- `snake_case.dart`
- Suffix por tipo:
  - `*_cubit.dart`, `*_state.dart`
  - `*_use_case.dart`
  - `*_screen.dart`
  - `*_repository.dart` (en `core` package)
  - `*_test.dart`
- ARBs: `app_<lang>.arb` (e.g. `app_es.arb`, `app_en.arb`).

### Clases
- `PascalCase`.
- `<Feature>Cubit`, `<Feature>State`, `<Feature>Loaded`, `<Feature>Error`.
- `<Action>UseCase` (e.g. `GetPlacesUseCase`).
- `<Feature>Screen`, `<Feature>Page`, `<Widget>Widget`.

### Variables y propiedades
- `camelCase` para variables y propiedades.
- `_privateField` con guion bajo para privados.
- `final` por defecto, `var` solo cuando necesite reasignación.
- `late final` para inicialización posterior.

### Constantes
- `lowerCamelCase` para constantes simples (`defaultTimeout`).
- `UPPER_SNAKE_CASE` para constantes compartidas globales (raro, solo si imitan ENVs).

---

## 🧬 3. Patrones obligatorios

### 3.1 State con `@freezed sealed class`

```dart
part of '<feature>_cubit.dart';

@freezed
sealed class <Feature>State with _$<Feature>State {
  const factory <Feature>State.initial() = <Feature>Initial;
  const factory <Feature>State.loading() = <Feature>Loading;
  const factory <Feature>State.loaded({required List<X> items}) = <Feature>Loaded;
  const factory <Feature>State.error(String error) = <Feature>Error;
}
```

**Reglas:**
- ✅ Siempre `sealed` (Dart 3).
- ✅ Mínimo 4 factories: `initial`, `loading`, `loaded`, `error`.
- ✅ Todas `const`.
- ✅ Nombres concretos para subclases (`<Feature>Initial`, no `<Feature>StateInitial`).
- ❌ No usar `@freezed class` sin `sealed` para States.

### 3.2 Cubit con DI por constructor

```dart
class <Feature>Cubit extends Cubit<<Feature>State> {
  final <Action>UseCase <action>UseCase;

  <Feature>Cubit({required this.<action>UseCase})
      : super(const <Feature>State.initial());

  Future<void> fetch() async {
    emit(const <Feature>State.loading());
    try {
      final result = await <action>UseCase.call(NoParams());
      emit(<Feature>State.loaded(items: result));
    } catch (e) {
      emit(<Feature>State.error(e.toString()));
    }
  }
}
```

**Reglas:**
- ✅ Use cases inyectados por constructor con `required`.
- ✅ Constructor pasa `super(const State.initial())`.
- ✅ Métodos públicos retornan `Future<void>`.
- ✅ Patrón `emit(loading) → emit(loaded/error)` siempre.
- ❌ No `try/catch` que silencien errores sin emitir `error`.
- ❌ No singleton estático dentro del Cubit (usar GetIt para dependencias).

### 3.3 Use Case implementa `UseCase<T, P>`

```dart
class <Action>UseCase implements UseCase<Future<List<X>>, NoParams> {
  final <X>Repository repository;
  <Action>UseCase({required this.repository});

  @override
  Future<List<X>> call(NoParams param) async => await repository.getX();
}
```

**Reglas:**
- ✅ Implementa `UseCase<ReturnType, ParamsType>`.
- ✅ `NoParams` (de `app/core/no_params.dart`) si no hay params.
- ✅ Single responsibility — un use case = una acción.
- ❌ No use cases con múltiples métodos.

### 3.4 DI con GetIt

```dart
sl
  ..registerLazySingleton<<Action>UseCase>(
    () => <Action>UseCase(repository: sl<<X>Repository>()),
  )
  ..registerLazySingleton<<Feature>Cubit>(
    () => <Feature>Cubit(<action>UseCase: sl<<Action>UseCase>()),
  );
```

**Orden de registro:** Service → Repository → Use Case → Cubit.

**`registerLazySingleton` vs `registerFactory`:**
- `registerLazySingleton`: por defecto. Estado compartido en toda la app.
- `registerFactory`: cuando necesitas instancia nueva por screen (e.g. `BookingFormCubit`).

### 3.5 BlocProvider en `app.dart`

```dart
BlocProvider.value(value: sl<<Feature>Cubit>()),
```

Se añade en el `MultiBlocProvider` de `lib/app/view/screens/app.dart`.

### 3.6 Routing con `auto_route`

**Decoración de Screen:**
```dart
@RoutePage()
class <Feature>Screen extends StatelessWidget {
  const <Feature>Screen({super.key});
  // ...
}
```

**Registro de ruta** (`app_router.dart`):
```dart
AutoRoute(page: <Feature>Route.page, path: '/<feature-kebab>'),
```

**Tras añadir ruta**:
```bash
fvm dart run build_runner build --delete-conflicting-outputs
```

**Navegación:**
- ✅ `context.router.push(<Feature>Route(args))`
- ✅ `context.router.maybePop()`
- ❌ `context.router.pop()` → usar `maybePop()`.
- ❌ `context.router.pushPath('/x')` → usar `push(XRoute())`.

---

## 🌐 4. Internacionalización (i18n)

### 4.1 Toda string visible se internacionaliza

```dart
// ✅ Bien
Text(context.l10n.welcomeMessage)
TextField(decoration: InputDecoration(labelText: context.l10n.email))

// ❌ Mal
Text('Bienvenido')
TextField(decoration: const InputDecoration(labelText: 'Email'))
```

### 4.2 Añadir nueva clave

1. **Editar AMBOS ARBs** (`app_es.arb` y `app_en.arb`):

```json
// app_es.arb
{
  "newFeatureTitle": "Mi título",
  "@newFeatureTitle": {
    "description": "Título de la nueva feature"
  }
}

// app_en.arb
{
  "newFeatureTitle": "My title"
}
```

2. **Regenerar**:
```bash
fvm flutter gen-l10n
# o (alternativa)
fvm flutter pub get
```

3. **Usar**:
```dart
context.l10n.newFeatureTitle
```

### 4.3 Reglas

- ✅ Claves en `camelCase` con prefijo de la feature: `bookingFormTitle`, `placeDetailsLoading`.
- ✅ Claves comunes con prefijo `common`: `commonSave`, `commonCancel`, `commonError`.
- ✅ JSON válido (sin commas trailing).
- ❌ No `Text('literal')`.
- ❌ No `const InputDecoration(labelText: l10n.X)` — `l10n` no es const.

---

## 🎨 5. Theming con `turbo_ui`

### 5.1 Tokens disponibles

```dart
import 'package:turbo_ui/turbo_ui.dart';

TurboColors.primary
TurboColors.secondary
TurboColors.error
TurboColors.success
TurboColors.warning
// ...

TurboTypography.headlineLarge
TurboTypography.bodyMedium
// ...

TurboSpacing.xs    // 4
TurboSpacing.sm    // 8
TurboSpacing.md    // 16
TurboSpacing.lg    // 24
TurboSpacing.xl    // 32
TurboSpacing.xxl   // 48

TurboRadius.sm     // 4
TurboRadius.md     // 8
TurboRadius.lg     // 16
// ...

TurboShadows.sm
TurboShadows.md
TurboShadows.lg

TurboDurations.fast      // 200ms
TurboDurations.medium    // 300ms
TurboDurations.slow      // 500ms

TurboButtonStyles.primary
TurboCardStyles.elevated
TurboInputStyles.outlined
```

### 5.2 Uso correcto vs. incorrecto

```dart
// ✅ Bien
Container(
  padding: const EdgeInsets.all(TurboSpacing.md),
  decoration: BoxDecoration(
    color: TurboColors.primary,
    borderRadius: BorderRadius.circular(TurboRadius.md),
    boxShadow: TurboShadows.md,
  ),
  child: Text(
    context.l10n.title,
    style: TurboTypography.headlineMedium.copyWith(
      color: Colors.white,
    ),
  ),
)

// ❌ Mal
Container(
  padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: const Color(0xFFFF003D),
    borderRadius: BorderRadius.circular(8),
    boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
  ),
  child: Text('Bienvenido', style: TextStyle(fontSize: 24)),
)
```

### 5.3 Theme-aware (claro/oscuro)

```dart
// ✅ Para colores que cambian con el tema
final colors = Theme.of(context).colorScheme;
Container(color: colors.surface)
Text('...', style: TextStyle(color: colors.onSurface))

// ✅ Para colores fijos de marca
Container(color: TurboColors.primary)
```

### 5.4 Opacidad

```dart
// ✅ Flutter 3.27+
TurboColors.primary.withValues(alpha: 0.5)

// ❌ Deprecated
TurboColors.primary.withOpacity(0.5)
```

---

## 🚫 6. Anti-patrones (resumen)

| ❌ Prohibido                                | ✅ Hacer                                  |
|--------------------------------------------|-------------------------------------------|
| `print('...')`                             | `debugPrint('...')` o `AppLogger.debug()` |
| `Color(0xFFFF003D)`                        | `TurboColors.primary`                     |
| `Colors.red`                               | `TurboColors.error` / theme-aware         |
| `.withOpacity(X)`                          | `.withValues(alpha: X)`                   |
| `Text('literal')`                          | `Text(context.l10n.X)`                    |
| `const InputDecoration(labelText: 'x')`    | Sin `const` + `context.l10n.X`            |
| `context.router.pop()`                     | `context.router.maybePop()`               |
| `context.router.pushPath('/x')`            | `context.router.push(XRoute())`           |
| `Cubit` sin tests                          | `Cubit` con ≥ 3 tests                     |
| `@freezed class` (sin sealed) para state   | `@freezed sealed class`                   |
| Inyección manual / Singletons globales     | GetIt + `init_config.dart`                |
| Archivo > 500 líneas                       | Extraer a widgets/helpers                 |
| Lógica de negocio en `build()`             | Lógica en Cubit / Use Case                |
| Imports relativos (`../../foo.dart`)       | Imports absolutos (`package:turbo/...`)   |
| `var`/`dynamic` sin necesidad              | Tipos explícitos                          |
| `try/catch` que silencia errores           | Manejar o re-lanzar explícitamente        |

---

## 🛠️ 7. Comandos de ciclo de desarrollo

### Setup
```bash
fvm install
fvm flutter pub get
cd ios && pod install --repo-update && cd ..
```

### Code generation (después de cambios en freezed/auto_route)
```bash
fvm dart run build_runner build --delete-conflicting-outputs
fvm dart run build_runner watch --delete-conflicting-outputs   # modo watch
```

### Localización (después de editar ARBs)
```bash
fvm flutter gen-l10n
```

### Run
```bash
fvm flutter run                                    # debug
fvm flutter run -d <device-id>                     # device específico
fvm flutter run --release                          # release mode
```

### Tests
```bash
fvm flutter test                                   # todos
fvm flutter test test/<feature>/                   # específico
fvm flutter test --coverage                        # con cobertura
fvm flutter test --name "emits"                    # por nombre
```

### Análisis
```bash
fvm flutter analyze                                # estático
fvm dart format lib/ test/                         # formatear
```

### Build production
```bash
fvm flutter build ios --release
fvm flutter build appbundle --release
fvm flutter build apk --release
```

> **Siempre usar `fvm flutter`** (NO `flutter` global). La versión está pinneada en `.fvmrc`.

---

## 📋 8. Estructura de un Widget

```dart
class MyWidget extends StatelessWidget {
  // 1. Propiedades (final)
  final String title;
  final VoidCallback? onTap;

  // 2. Constructor
  const MyWidget({
    super.key,
    required this.title,
    this.onTap,
  });

  // 3. Build
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final l10n = context.l10n;
    
    return Container(
      // ...
    );
  }

  // 4. Métodos privados de UI (si aplica)
  Widget _buildHeader() => Container();
}
```

---

## 📋 9. Estructura de un Cubit

```dart
class <Feature>Cubit extends Cubit<<Feature>State> {
  // 1. Dependencias
  final <Action>UseCase <action>UseCase;

  // 2. Constructor
  <Feature>Cubit({required this.<action>UseCase})
      : super(const <Feature>State.initial());

  // 3. Métodos públicos (acciones)
  Future<void> fetch() async { ... }
  Future<void> refresh() async { ... }

  // 4. Métodos privados (helpers)
  void _handleError(Object error) { ... }
}
```

---

## 🎓 10. Resumen de "Hecho"

Una contribución está **"hecha"** cuando:

- [ ] Sigue todas las convenciones de este documento.
- [ ] Tiene ≥ 3 tests pasando (`fvm flutter test`).
- [ ] Cobertura ≥ 80% en `state_management/` y `module/`.
- [ ] `fvm flutter analyze` está limpio.
- [ ] Sin anti-patrones de la sección § 6.
- [ ] Documentación actualizada en `doc/`.
- [ ] Internacionalización completa (ES + EN).
- [ ] Funciona en tema claro Y oscuro.
- [ ] Pasa `/review` con veredicto 🟢.

---

**Recuerda:** estas convenciones existen para que el código del equipo sea coherente, testeable y mantenible. Romperlas no es un atajo, es deuda técnica.
