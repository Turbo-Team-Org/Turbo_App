# ⚡ Referencia Rápida de Testing

## 🚀 Comandos Más Usados

```bash
# Ejecutar todos los tests
flutter test

# Ejecutar un archivo específico
flutter test test/places/cubit/places_cubit_test.dart

# Ejecutar con cobertura
flutter test --coverage

# Ejecutar tests que contengan un término
flutter test --name "Loading"

# Ver tests disponibles sin ejecutarlos
flutter test --dry-run

# Ejecutar en modo verbose
flutter test --verbose
```

---

## 📝 Estructura Básica de un Test

```dart
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// 1. Crear Mocks
class MockDependency extends Mock implements Dependency {}

void main() {
  // 2. Setup inicial (una vez)
  setUpAll(() {
    registerFallbackValue(FallbackType());
  });

  group('MyCubit', () {
    late MyCubit cubit;
    late MockDependency mockDep;

    // 3. Setup antes de cada test
    setUp(() {
      mockDep = MockDependency();
      cubit = MyCubit(dependency: mockDep);
    });

    // 4. Cleanup después de cada test
    tearDown(() {
      cubit.close();
    });

    // 5. Tests
    test('estado inicial', () {
      expect(cubit.state, InitialState());
    });

    blocTest<MyCubit, MyState>(
      'caso de éxito',
      build: () {
        when(() => mockDep.method())
            .thenAnswer((_) async => data);
        return cubit;
      },
      act: (c) => c.action(),
      expect: () => [LoadingState(), SuccessState()],
    );
  });
}
```

---

## 🎭 Mocktail Cheat Sheet

### Crear Mock
```dart
class MockRepository extends Mock implements Repository {}
```

### Configurar Respuesta
```dart
// Respuesta simple
when(() => mock.method()).thenReturn(value);

// Respuesta async
when(() => mock.method()).thenAnswer((_) async => value);

// Lanzar excepción
when(() => mock.method()).thenThrow(Exception('Error'));

// Respuestas diferentes por llamada
when(() => mock.method())
  .thenAnswer((_) async => value1)
  .thenAnswer((_) async => value2);
```

### Verificar Llamadas
```dart
// Llamado exactamente 1 vez (default)
verify(() => mock.method()).called(1);

// Llamado 0 veces
verifyNever(() => mock.method());

// Llamado al menos 1 vez
verify(() => mock.method()).called(greaterThan(0));

// Verificar orden
verifyInOrder([
  () => mock.method1(),
  () => mock.method2(),
]);
```

### Capturar Argumentos
```dart
when(() => mock.method(captureAny()))
    .thenReturn(value);

final captured = verify(
  () => mock.method(captureAny())
).captured;

expect(captured.first, expectedValue);
```

---

## 🔍 Matchers Más Usados

### Igualdad
```dart
expect(actual, expected);
expect(actual, equals(expected));
expect(actual, isNot(expected));
```

### Tipos
```dart
expect(actual, isA<MyClass>());
expect(actual, isNotNull);
expect(actual, isNull);
```

### Números
```dart
expect(actual, greaterThan(5));
expect(actual, lessThan(10));
expect(actual, greaterThanOrEqualTo(5));
expect(actual, closeTo(5.0, 0.1)); // 5.0 ± 0.1
```

### Strings
```dart
expect(actual, contains('texto'));
expect(actual, startsWith('inicio'));
expect(actual, endsWith('fin'));
expect(actual, matches(RegExp(r'\d+')));
```

### Colecciones
```dart
expect(actual, isEmpty);
expect(actual, isNotEmpty);
expect(actual, hasLength(3));
expect(actual, contains(item));
expect(actual, containsAll([item1, item2]));
expect(actual, everyElement(isPositive));
```

### Combinaciones
```dart
expect(actual, allOf([
  isA<MyClass>(),
  isNotNull,
]));

expect(actual, anyOf([
  equals(1),
  equals(2),
]));
```

### Having (para propiedades)
```dart
expect(user, isA<User>()
  .having((u) => u.name, 'name', 'Juan')
  .having((u) => u.age, 'age', greaterThan(18))
);
```

---

## 🧪 bloc_test Cheat Sheet

### Test Básico
```dart
blocTest<MyCubit, MyState>(
  'descripción',
  build: () => cubit,
  act: (c) => c.action(),
  expect: () => [State1(), State2()],
);
```

### Con Setup
```dart
blocTest<MyCubit, MyState>(
  'descripción',
  build: () {
    when(() => mock.method()).thenReturn(data);
    return MyCubit(mock);
  },
  act: (c) => c.action(),
  expect: () => [State1(), State2()],
);
```

### Con Seed (estado inicial personalizado)
```dart
blocTest<MyCubit, MyState>(
  'descripción',
  build: () => cubit,
  seed: () => LoadedState(data),
  act: (c) => c.action(),
  expect: () => [UpdatedState()],
);
```

### Con Wait (esperar antes de verificar)
```dart
blocTest<MyCubit, MyState>(
  'descripción',
  build: () => cubit,
  act: (c) => c.action(),
  wait: const Duration(milliseconds: 100),
  expect: () => [State1()],
);
```

### Con Skip (saltar primeros estados)
```dart
blocTest<MyCubit, MyState>(
  'descripción',
  build: () => cubit,
  act: (c) => c.action(),
  skip: 1, // Salta el primer estado emitido
  expect: () => [State2()],
);
```

### Con Verify
```dart
blocTest<MyCubit, MyState>(
  'descripción',
  build: () => cubit,
  act: (c) => c.action(),
  expect: () => [State1()],
  verify: (_) {
    verify(() => mock.method()).called(1);
  },
);
```

### Con Errors
```dart
blocTest<MyCubit, MyState>(
  'descripción',
  build: () => cubit,
  act: (c) => c.action(),
  errors: () => [isA<Exception>()],
);
```

---

## 📊 Patrones Comunes

### Test de Estado Inicial
```dart
test('inicializa con estado correcto', () {
  final cubit = MyCubit();
  expect(cubit.state, InitialState());
  cubit.close();
});
```

### Test de Caso de Éxito
```dart
blocTest<MyCubit, MyState>(
  'emite success cuando operación exitosa',
  build: () {
    when(() => mock.getData())
        .thenAnswer((_) async => data);
    return MyCubit(mock);
  },
  act: (c) => c.loadData(),
  expect: () => [
    LoadingState(),
    SuccessState(data),
  ],
);
```

### Test de Caso de Error
```dart
blocTest<MyCubit, MyState>(
  'emite error cuando operación falla',
  build: () {
    when(() => mock.getData())
        .thenThrow(Exception('Error'));
    return MyCubit(mock);
  },
  act: (c) => c.loadData(),
  expect: () => [
    LoadingState(),
    ErrorState('Exception: Error'),
  ],
);
```

### Test de Lista Vacía
```dart
blocTest<MyCubit, MyState>(
  'maneja lista vacía correctamente',
  build: () {
    when(() => mock.getData())
        .thenAnswer((_) async => []);
    return MyCubit(mock);
  },
  act: (c) => c.loadData(),
  expect: () => [
    LoadingState(),
    EmptyState(),
  ],
);
```

### Test de Múltiples Llamadas
```dart
blocTest<MyCubit, MyState>(
  'puede llamarse múltiples veces',
  build: () {
    when(() => mock.getData())
        .thenAnswer((_) async => data);
    return MyCubit(mock);
  },
  act: (c) async {
    await c.loadData();
    await c.loadData();
  },
  expect: () => [
    LoadingState(),
    SuccessState(data),
    LoadingState(),
    SuccessState(data),
  ],
  verify: (_) {
    verify(() => mock.getData()).called(2);
  },
);
```

### Test de Timeout
```dart
blocTest<MyCubit, MyState>(
  'maneja timeout correctamente',
  build: () {
    when(() => mock.getData()).thenAnswer(
      (_) async => Future.delayed(
        Duration(seconds: 5),
        () => data,
      ),
    );
    return MyCubit(mock);
  },
  act: (c) => c.loadData(),
  expect: () => [
    LoadingState(),
    TimeoutState(),
  ],
  timeout: Duration(seconds: 3),
);
```

---

## 🐛 Errores Comunes y Soluciones

### MissingStubError
```dart
// ❌ Error
when(() => mock.method(any())).thenReturn(value);

// ✅ Solución
setUpAll(() {
  registerFallbackValue(ParameterType());
});
```

### StateError: No element
```dart
// ❌ Error: esperas estados que no se emiten
expect: () => [State1(), State2()],

// ✅ Verifica qué estados realmente se emiten
print(cubit.stream);
```

### Can't emit after close
```dart
// ❌ Error: cubit cerrado muy pronto
tearDown(() {
  cubit.close();
});
act: (c) => c.action(); // Intenta emitir después de close

// ✅ Asegúrate que tearDown se ejecute después
```

### Tests fallan aleatoriamente
```dart
// ❌ Problema: estado compartido
final sharedData = [];
test('test1', () { sharedData.add(1); });
test('test2', () { expect(sharedData, isEmpty); }); // Falla

// ✅ Solución: usar setUp
setUp(() {
  testData = [];
});
```

---

## 📈 Métricas

### Ver Cobertura
```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

### Objetivos de Cobertura
- 🔴 < 60%: Insuficiente
- 🟡 60-80%: Aceptable
- 🟢 80-100%: Excelente

### Qué Testear Primero
1. ✅ Lógica de negocio (Cubits, Repositories)
2. ✅ Use Cases
3. ✅ Widgets complejos
4. ⚠️ Widgets simples (opcional)
5. ❌ Código generado (no necesario)

---

## 🎯 Checklist por Feature

- [ ] Estado inicial
- [ ] Caso de éxito
- [ ] Caso de error
- [ ] Lista vacía (si aplica)
- [ ] Validaciones
- [ ] Edge cases
- [ ] Múltiples llamadas (si aplica)
- [ ] Interacción con dependencias
- [ ] Cobertura > 80%
- [ ] Todos los tests pasan

---

## 💡 Tips Rápidos

1. **Nombres descriptivos:** El nombre debe explicar qué testea
2. **AAA:** Arrange-Act-Assert siempre
3. **Un test, una cosa:** No testees múltiples comportamientos
4. **Independencia:** Tests no deben depender entre sí
5. **Velocidad:** Tests deben ser rápidos (< 1 segundo)
6. **Determinismo:** Mismo resultado siempre
7. **Cleanup:** Cierra Cubits en tearDown
8. **Mocks:** Mockea dependencias externas siempre

---

## 🔗 Links Útiles

- [Flutter Testing Docs](https://docs.flutter.dev/testing)
- [Bloc Testing](https://bloclibrary.dev/#/testing)
- [Mocktail Package](https://pub.dev/packages/mocktail)
- [bloc_test Package](https://pub.dev/packages/bloc_test)

---

## 🎓 Para Aprender Más

1. Lee: `TESTING_GUIDE.md` (teoría completa)
2. Practica: `TUTORIAL_PASO_A_PASO.md` (ejercicios)
3. Consulta: `QUICK_REFERENCE.md` (este archivo)
4. Revisa: `places_cubit_test.dart` (ejemplo completo)

---

**¡Happy Testing! 🚀**

