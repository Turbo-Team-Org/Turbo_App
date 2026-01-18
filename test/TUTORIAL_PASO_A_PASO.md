# 🎓 Tutorial Paso a Paso: Escribiendo Tu Primer Test con Bloc

## 📋 Prerequisitos

Antes de empezar, asegúrate de tener estas dependencias en tu `pubspec.yaml`:

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  bloc_test: ^10.0.0
  mocktail: ^1.0.0
```

---

## 🚀 Paso 1: Entender el Código a Testear

Primero, veamos el Cubit que vamos a testear:

```dart
// place_cubit.dart
class PlaceCubit extends Cubit<PlaceState> {
  final GetPlacesUseCase getPlacesUseCase;

  PlaceCubit({
    required this.getPlacesUseCase,
  }) : super(const PlaceState.initial());

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

### Análisis:
1. **Dependencia:** `GetPlacesUseCase` (tendremos que mockearla)
2. **Estado inicial:** `PlaceState.initial()`
3. **Método a testear:** `getPlaces()`
4. **Flujo:**
   - Emite `PlacesLoading`
   - Llama al use case
   - Si éxito → emite `PlacesLoaded`
   - Si error → emite `PlacesError`

---

## 📝 Paso 2: Crear el Archivo de Test

Crea el archivo: `test/places/cubit/places_cubit_test.dart`

```dart
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:core/core.dart';
import 'package:turbo/places/state_management/place_bloc/cubit/place_cubit.dart';
import 'package:turbo/places/module/get_places_use_case.dart';
import 'package:turbo/app/core/no_params.dart';

void main() {
  // Aquí irán nuestros tests
}
```

---

## 🎭 Paso 3: Crear los Mocks

Los mocks simulan el comportamiento de las dependencias reales.

```dart
// Crear clase mock del use case
class MockGetPlacesUseCase extends Mock implements GetPlacesUseCase {}

void main() {
  // Registrar fallback values (para parámetros genéricos)
  setUpAll(() {
    registerFallbackValue(NoParams());
  });
}
```

**¿Por qué MockGetPlacesUseCase?**
- No queremos llamar a la API real en tests
- Queremos controlar exactamente qué devuelve
- Tests deben ser rápidos y determinísticos

---

## 🏗️ Paso 4: Configurar setUp y tearDown

```dart
void main() {
  setUpAll(() {
    registerFallbackValue(NoParams());
  });

  group('PlaceCubit Tests', () {
    late PlaceCubit cubit;
    late MockGetPlacesUseCase mockGetPlacesUseCase;

    // Se ejecuta ANTES de cada test
    setUp(() {
      mockGetPlacesUseCase = MockGetPlacesUseCase();
      cubit = PlaceCubit(getPlacesUseCase: mockGetPlacesUseCase);
    });

    // Se ejecuta DESPUÉS de cada test
    tearDown(() {
      cubit.close(); // Importante: cerrar el cubit para evitar memory leaks
    });

    // Aquí irán los tests
  });
}
```

---

## ✅ Paso 5: Test del Estado Inicial

**Objetivo:** Verificar que el cubit se inicializa con el estado correcto.

```dart
test('debe inicializarse con PlacesInitial', () {
  // ASSERT: Verificamos el estado inicial
  expect(cubit.state, const PlaceState.initial());
});
```

### Ejecutar el test:
```bash
flutter test test/places/cubit/places_cubit_test.dart
```

**Si pasa ✅:** ¡Excelente! Primer test completado.

**Si falla ❌:** Revisa:
- ¿El cubit realmente se inicializa con `PlaceState.initial()`?
- ¿Importaste correctamente los archivos?

---

## 🟢 Paso 6: Test del Caso de Éxito

**Objetivo:** Verificar que cuando `getPlaces()` es exitoso, se emiten los estados correctos.

```dart
blocTest<PlaceCubit, PlaceState>(
  'emits [Loading, Loaded] cuando getPlaces() es exitoso',
  
  // ========== ARRANGE ==========
  build: () {
    // 1. Crear datos de prueba
    final testPlaces = [
      Place(
        id: '1',
        name: 'Restaurante Test',
        description: 'Descripción test',
        categoryId: 'cat1',
        address: 'Calle Test 123',
        latitude: 0.0,
        longitude: 0.0,
        rating: 4.5,
        images: const ['image1.jpg'],
        openingHours: const {'lunes': '9:00-18:00'},
        amenities: const ['wifi'],
        contactInfo: const {'phone': '123456789'},
        createdAt: DateTime(2024),
        updatedAt: DateTime(2024),
      ),
    ];

    // 2. Configurar el mock para que devuelva nuestros datos
    when(() => mockGetPlacesUseCase.call(any()))
        .thenAnswer((_) async => testPlaces);

    // 3. Devolver el cubit
    return cubit;
  },
  
  // ========== ACT ==========
  act: (cubit) => cubit.getPlaces(),
  
  // ========== ASSERT ==========
  expect: () => [
    const PlaceState.loading(),
    isA<PlacesLoaded>()
        .having((s) => s.places.length, 'cantidad de places', 1)
        .having((s) => s.places.first.name, 'nombre del primer place', 'Restaurante Test'),
  ],
  
  // Verificar que el use case fue llamado
  verify: (_) {
    verify(() => mockGetPlacesUseCase.call(any())).called(1);
  },
);
```

### Desglose del Test:

1. **build:** Preparamos todo (mocks, datos, cubit)
2. **act:** Ejecutamos la acción a testear
3. **expect:** Verificamos los estados emitidos EN ORDEN
4. **verify:** Verificamos que las dependencias fueron llamadas correctamente

### Conceptos Clave:

**`when(() => mockGetPlacesUseCase.call(any()))`**
- Configura el comportamiento del mock
- "Cuando se llame al use case con cualquier parámetro..."

**`.thenAnswer((_) async => testPlaces)`**
- "...devuelve estos datos de prueba"

**`isA<PlacesLoaded>()`**
- Verifica que el estado es del tipo `PlacesLoaded`

**`.having(...)`**
- Verifica propiedades específicas del estado
- Parámetros: (getter, descripción, valor esperado)

---

## 🔴 Paso 7: Test del Caso de Error

**Objetivo:** Verificar que cuando `getPlaces()` falla, se maneja el error correctamente.

```dart
blocTest<PlaceCubit, PlaceState>(
  'emits [Loading, Error] cuando getPlaces() falla',
  
  // ========== ARRANGE ==========
  build: () {
    // Configurar el mock para que lance una excepción
    when(() => mockGetPlacesUseCase.call(any()))
        .thenThrow(Exception('Error al obtener lugares'));
    
    return cubit;
  },
  
  // ========== ACT ==========
  act: (cubit) => cubit.getPlaces(),
  
  // ========== ASSERT ==========
  expect: () => [
    const PlaceState.loading(),
    isA<PlacesError>()
        .having((s) => s.error, 'mensaje de error', contains('Error al obtener lugares')),
  ],
  
  verify: (_) {
    verify(() => mockGetPlacesUseCase.call(any())).called(1);
  },
);
```

### Nuevo Concepto:

**`.thenThrow(Exception('...'))`**
- Hace que el mock lance una excepción
- Simula un error de red, base de datos, etc.

**`contains('...')`**
- Matcher que verifica que un string contiene un texto
- Útil cuando el mensaje de error puede variar

---

## 🔍 Paso 8: Test de Lista Vacía

**Objetivo:** Verificar que el cubit maneja correctamente cuando no hay datos.

```dart
blocTest<PlaceCubit, PlaceState>(
  'emits [Loading, Loaded] con lista vacía cuando no hay lugares',
  
  build: () {
    // Mock devuelve lista vacía
    when(() => mockGetPlacesUseCase.call(any()))
        .thenAnswer((_) async => []);
    
    return cubit;
  },
  
  act: (cubit) => cubit.getPlaces(),
  
  expect: () => [
    const PlaceState.loading(),
    isA<PlacesLoaded>()
        .having((s) => s.places, 'places', isEmpty),
  ],
);
```

### Nuevo Concepto:

**`isEmpty`**
- Matcher que verifica que una colección está vacía
- Equivalente a: `having((s) => s.places.length, 'length', 0)`

---

## 🔄 Paso 9: Test de Múltiples Llamadas

**Objetivo:** Verificar que el cubit puede ser llamado múltiples veces.

```dart
blocTest<PlaceCubit, PlaceState>(
  'puede llamar getPlaces() múltiples veces correctamente',
  
  build: () {
    when(() => mockGetPlacesUseCase.call(any()))
        .thenAnswer((_) async => [
          Place(
            id: '1',
            name: 'Test',
            description: 'Test',
            categoryId: 'cat1',
            address: 'Test',
            latitude: 0.0,
            longitude: 0.0,
            rating: 4.0,
            images: const [],
            openingHours: const {},
            amenities: const [],
            contactInfo: const {},
            createdAt: DateTime(2024),
            updatedAt: DateTime(2024),
          ),
        ]);
    
    return cubit;
  },
  
  act: (cubit) async {
    await cubit.getPlaces();
    await cubit.getPlaces(); // Segunda llamada
  },
  
  expect: () => [
    const PlaceState.loading(),
    isA<PlacesLoaded>(),
    const PlaceState.loading(),    // Segunda vez
    isA<PlacesLoaded>(),           // Segunda vez
  ],
  
  verify: (_) {
    verify(() => mockGetPlacesUseCase.call(any())).called(2);
  },
);
```

### Nuevos Conceptos:

**`act: (cubit) async { ... }`**
- Puedes ejecutar múltiples acciones
- Útil para testear flujos complejos

**`.called(2)`**
- Verifica que el método fue llamado exactamente 2 veces

---

## 📊 Paso 10: Ejecutar y Verificar Cobertura

### Ejecutar todos los tests:
```bash
flutter test test/places/cubit/places_cubit_test.dart
```

### Ver cobertura de código:
```bash
flutter test --coverage
```

### Generar reporte HTML:
```bash
# Instalar lcov (una sola vez)
brew install lcov  # macOS
# sudo apt-get install lcov  # Linux

# Generar reporte
genhtml coverage/lcov.info -o coverage/html

# Abrir en navegador
open coverage/html/index.html  # macOS
# xdg-open coverage/html/index.html  # Linux
```

---

## 🎯 Resumen de Comandos

```bash
# Ejecutar un archivo de test
flutter test test/places/cubit/places_cubit_test.dart

# Ejecutar todos los tests
flutter test

# Ejecutar con cobertura
flutter test --coverage

# Ejecutar tests que contengan "Loading" en el nombre
flutter test --name "Loading"

# Ejecutar en modo verbose
flutter test --verbose
```

---

## 🧩 Plantilla Completa

Aquí está la estructura completa que puedes usar como plantilla:

```dart
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
// Importa tus archivos aquí

// 1. CREAR MOCKS
class MockYourDependency extends Mock implements YourDependency {}

void main() {
  // 2. REGISTRAR FALLBACKS (si es necesario)
  setUpAll(() {
    registerFallbackValue(YourFallbackValue());
  });

  group('YourCubit Tests', () {
    // 3. DECLARAR VARIABLES
    late YourCubit cubit;
    late MockYourDependency mockDependency;

    // 4. SETUP
    setUp(() {
      mockDependency = MockYourDependency();
      cubit = YourCubit(dependency: mockDependency);
    });

    // 5. TEARDOWN
    tearDown(() {
      cubit.close();
    });

    // 6. TEST DE ESTADO INICIAL
    test('debe inicializarse con estado inicial', () {
      expect(cubit.state, InitialState());
    });

    // 7. TEST DE CASO DE ÉXITO
    blocTest<YourCubit, YourState>(
      'descripción del comportamiento exitoso',
      build: () {
        when(() => mockDependency.method())
            .thenAnswer((_) async => expectedData);
        return cubit;
      },
      act: (cubit) => cubit.yourMethod(),
      expect: () => [
        LoadingState(),
        SuccessState(data: expectedData),
      ],
    );

    // 8. TEST DE CASO DE ERROR
    blocTest<YourCubit, YourState>(
      'descripción del comportamiento con error',
      build: () {
        when(() => mockDependency.method())
            .thenThrow(Exception('Error'));
        return cubit;
      },
      act: (cubit) => cubit.yourMethod(),
      expect: () => [
        LoadingState(),
        ErrorState(message: 'Error'),
      ],
    );

    // 9. OTROS TESTS...
  });
}
```

---

## 🎓 Ejercicios Prácticos

### Ejercicio 1: Test de Búsqueda
Imagina que tu cubit tiene este método:

```dart
Future<void> searchPlaces(String query) async {
  if (query.isEmpty) {
    emit(const PlaceState.empty());
    return;
  }
  
  emit(const PlaceState.loading());
  try {
    final places = await searchPlacesUseCase.call(query);
    emit(PlaceState.loaded(places: places));
  } catch (e) {
    emit(PlacesError(e.toString()));
  }
}
```

**Tu tarea:** Escribe tests para:
1. Query vacío emite `PlaceState.empty()`
2. Query con resultados emite `[Loading, Loaded]`
3. Query sin resultados emite `[Loading, Loaded]` con lista vacía
4. Query que falla emite `[Loading, Error]`

### Ejercicio 2: Test de Filtrado
```dart
void filterByCategory(String categoryId) {
  final currentState = state;
  if (currentState is PlacesLoaded) {
    final filtered = currentState.places
        .where((p) => p.categoryId == categoryId)
        .toList();
    emit(PlaceState.loaded(places: filtered));
  }
}
```

**Tu tarea:** Escribe tests para:
1. Filtrar desde estado loaded funciona
2. Filtrar desde estado inicial no hace nada
3. Filtrar con categoría inexistente devuelve lista vacía

---

## 🐛 Problemas Comunes

### Error: "MissingStubError"
```
MissingStubError: 'call'
No stub was found which matches the arguments of this method call:
```

**Solución:** Registra el fallback value
```dart
setUpAll(() {
  registerFallbackValue(YourParameterType());
});
```

### Error: Tests fallan aleatoriamente
**Causa:** Estado compartido entre tests

**Solución:** 
- Usa `setUp()` y `tearDown()` correctamente
- Cierra los cubits en `tearDown()`
- No uses variables globales

### Error: "Bad state: Cannot emit new states after calling close"
**Causa:** Intentas emitir estados después de cerrar el cubit

**Solución:**
```dart
tearDown(() {
  cubit.close();
});
```

### Test pasa pero cobertura es baja
**Causa:** No estás testeando todos los caminos del código

**Solución:** Revisa el reporte de cobertura y añade tests para código no cubierto

---

## ✅ Checklist de Test Completo

Antes de considerar que has terminado de testear un Cubit, verifica:

- [ ] Test de estado inicial
- [ ] Test de cada método público
- [ ] Test de caso de éxito
- [ ] Test de caso de error
- [ ] Test de lista vacía (si aplica)
- [ ] Test de múltiples llamadas (si aplica)
- [ ] Test de edge cases
- [ ] Todos los tests pasan
- [ ] Cobertura > 80%
- [ ] No hay tests flakey

---

## 🚀 Próximos Pasos

1. ✅ Completa los tests del `PlaceCubit`
2. ✅ Practica con otros Cubits de tu app
3. ✅ Lee sobre Widget Testing
4. ✅ Aprende Integration Testing
5. ✅ Implementa TDD en tu próxima feature

---

## 💡 Consejos Finales

1. **Empieza simple:** No intentes testear todo de una vez
2. **Sé consistente:** Usa la misma estructura en todos tus tests
3. **Nombres descriptivos:** El nombre del test debe explicar qué hace
4. **Un test, una cosa:** No testees múltiples comportamientos en un test
5. **Red-Green-Refactor:** Escribe el test, hazlo pasar, refactoriza
6. **Tests son documentación:** Escríbelos pensando que alguien los leerá

---

## 🎉 ¡Felicitaciones!

Has completado el tutorial de testing con Bloc. Ahora tienes las herramientas para:
- ✅ Escribir tests unitarios para Cubits
- ✅ Mockear dependencias con Mocktail
- ✅ Verificar emisión de estados con bloc_test
- ✅ Medir cobertura de código
- ✅ Entender la filosofía del testing

**¡Sigue practicando y happy testing! 🚀**

