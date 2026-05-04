# 🧪 Guía TDD — Turbo App

> **Política del proyecto:** mínimo 3 tests por feature, ciclo Red → Green → Refactor estricto.  
> Para guía teórica completa ver `test/TESTING_GUIDE.md`. Este documento es la guía **operativa** del proyecto.

---

## 🎯 Reglas obligatorias del proyecto

### 1. Mínimo 3 tests por feature

Toda nueva feature (Cubit, Use Case crítico, widget con lógica) DEBE tener **al menos 3 tests**:

| # | Tipo                | Cubre                                           |
|---|---------------------|-------------------------------------------------|
| 1 | Estado inicial      | Construcción correcta del Cubit                 |
| 2 | Caso éxito          | Loading → Loaded con datos correctos            |
| 3 | Caso error          | Loading → Error con mensaje correcto            |

### 2. RED-first inquebrantable

```
1. Escribir test
2. Ejecutar → FALLA (no hay código aún)
3. Solo entonces escribir código
```

Si el test pasa al primer intento (sin haber escrito el código), el test está mal escrito.

### 3. Cobertura objetivo

| Carpeta                    | Mínimo cobertura |
|----------------------------|------------------|
| `lib/<f>/state_management/` | **80%**          |
| `lib/<f>/module/`           | **80%**          |
| Total proyecto              | **60%**          |

### 4. AAA siempre visible

```dart
test('descripción', () {
  // ARRANGE
  ...
  
  // ACT
  ...
  
  // ASSERT
  ...
});
```

---

## 🛠️ Stack de testing del proyecto

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  bloc_test: ^10.0.0
  mocktail: ^1.0.0
```

- **`bloc_test`**: testing especializado de Blocs/Cubits.
- **`mocktail`**: mocks sin generación de código.
- **`flutter_test`**: framework base.

---

## 📁 Estructura de tests

```
test/
├── <feature>/
│   ├── cubit/
│   │   └── <feature>_cubit_test.dart        ← obligatorio
│   ├── use_cases/
│   │   └── <action>_use_case_test.dart      ← cuando hay lógica no trivial
│   └── widgets/
│       └── <widget>_test.dart               ← opcional
├── README.md
├── TESTING_GUIDE.md                          ← guía teórica
└── widget_test.dart                          ← test de smoke
```

---

## 📝 Plantilla obligatoria — Cubit test

> Se debe seguir esta estructura. Hay un archivo de referencia funcionando en `test/places/cubit/places_cubit_test.dart`.

```dart
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:turbo/<feature>/state_management/<feature>_cubit/cubit/<feature>_cubit.dart';
import 'package:turbo/<feature>/module/<action>_use_case.dart';
import 'package:turbo/app/core/no_params.dart';
import 'package:core/core.dart';

class MockGet<X>UseCase extends Mock implements <Action>UseCase {}

void main() {
  setUpAll(() {
    registerFallbackValue(NoParams());
  });

  group('<Feature>Cubit', () {
    late <Feature>Cubit cubit;
    late MockGet<X>UseCase mockUseCase;

    setUp(() {
      mockUseCase = MockGet<X>UseCase();
      cubit = <Feature>Cubit(<action>UseCase: mockUseCase);
    });

    tearDown(() => cubit.close());

    // TEST 1 — OBLIGATORIO
    test('starts with <Feature>State.initial()', () {
      expect(cubit.state, const <Feature>State.initial());
    });

    // TEST 2 — OBLIGATORIO
    blocTest<<Feature>Cubit, <Feature>State>(
      'emits [loading, loaded] on successful fetch',
      build: () {
        when(() => mockUseCase.call(any()))
            .thenAnswer((_) async => testData);
        return cubit;
      },
      act: (c) => c.fetch(),
      expect: () => [
        const <Feature>State.loading(),
        isA<<Feature>Loaded>(),
      ],
      verify: (_) {
        verify(() => mockUseCase.call(any())).called(1);
      },
    );

    // TEST 3 — OBLIGATORIO
    blocTest<<Feature>Cubit, <Feature>State>(
      'emits [loading, error] on fetch failure',
      build: () {
        when(() => mockUseCase.call(any()))
            .thenThrow(Exception('Test error'));
        return cubit;
      },
      act: (c) => c.fetch(),
      expect: () => [
        const <Feature>State.loading(),
        isA<<Feature>Error>(),
      ],
    );
  });
}
```

---

## 🚀 Comandos esenciales

```bash
# Toda la suite
fvm flutter test

# Específico
fvm flutter test test/places/cubit/places_cubit_test.dart

# Por nombre
fvm flutter test --name "emits [loading, loaded]"

# Con cobertura
fvm flutter test --coverage

# Reporte HTML
brew install lcov              # solo primera vez
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html

# Verbose
fvm flutter test --verbose
```

---

## 🎓 Buenas prácticas (top 10 críticas)

1. **Un test, un comportamiento**: si tu test verifica 3 cosas, son 3 tests.
2. **Nombres descriptivos**: `'emits [loading, loaded] when getPlaces succeeds'` > `'works'`.
3. **Mockea TODO lo externo**: APIs, bases de datos, `DateTime.now()`, `Random`.
4. **Tests independientes**: nunca dependas del orden de ejecución.
5. **`setUp` para crear**, **`tearDown` para limpiar** (`cubit.close()` SIEMPRE).
6. **Testea comportamiento, no implementación**: si refactorizas y rompe el test, es buen test.
7. **Verifica orden de estados con `expect: () => [...]`**.
8. **Usa `isA<X>().having(...)` para validaciones complejas**.
9. **`registerFallbackValue` en `setUpAll`** para tipos custom usados con `any()`.
10. **No tests "flaky"**: si un test pasa a veces, es bug del test, no del código.

---

## 🐛 Troubleshooting de tests

### `MissingStubError`

```
Bad state: A test tried to use any() with a class but no fallback was registered.
```

Solución:
```dart
setUpAll(() {
  registerFallbackValue(NoParams());
  registerFallbackValue(MyCustomParam());
});
```

### `Bad state: Cannot emit new states after closing`

Falta `tearDown(() => cubit.close())` o el test no espera correctamente.

### `freezed` factory no encontrado

```bash
fvm dart run build_runner build --delete-conflicting-outputs
```

### Estados emitidos en orden incorrecto

Verificar que el Cubit hace `emit(loading)` ANTES de `emit(loaded/error)`.

```dart
// ✅ Bien
Future<void> fetch() async {
  emit(const State.loading());          // ← primero
  try {
    final data = await useCase.call(...);
    emit(State.loaded(data));            // ← después
  } catch (e) {
    emit(State.error(e.toString()));
  }
}
```

### Tests pasan localmente pero fallan en CI

- Probable: tests dependen de `DateTime.now()` o `Random` no mockeados.
- Solución: inyectar providers mockeables.

---

## 📊 Métricas de calidad por test

| Métrica           | Objetivo                          |
|-------------------|-----------------------------------|
| Tests unitarios   | 70% del total                     |
| Widget tests      | 20% del total                     |
| Integration tests | 10% del total                     |
| Tiempo total      | < 10s para unit, < 1min total     |
| Flakiness         | 0%                                |
| Cobertura         | ≥ 80% en lógica de negocio        |

---

## ✅ Checklist post-implementación

- [ ] ≥ 3 tests escritos por nuevo Cubit
- [ ] Tests siguen estructura AAA
- [ ] Nombres descriptivos
- [ ] `setUp` y `tearDown` correctos
- [ ] Mocks configurados (`when` + `verify` cuando aplique)
- [ ] `registerFallbackValue` para tipos custom
- [ ] Tests pasan: `fvm flutter test`
- [ ] Cobertura ≥ 80%: `fvm flutter test --coverage`
- [ ] Sin tests "flaky" (correr 3 veces consecutivas → siempre pasan)

---

## 🔗 Referencias

- `test/TESTING_GUIDE.md` — guía teórica completa.
- `test/places/cubit/places_cubit_test.dart` — referencia funcional.
- `.claude/agents/tester.md` — agente Tester con todas las reglas.
- `.claude/templates/cubit_test_template.dart` — plantilla copiable.

---

**Recuerda:** "Code without tests is broken by design." — Jacob Kaplan-Moss
