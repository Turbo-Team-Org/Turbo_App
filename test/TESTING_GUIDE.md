# 🧪 Guía Completa de Testing en Flutter con Bloc/Cubit

## 📚 Tabla de Contenidos

1. [¿Por Qué Testear?](#por-qué-testear)
2. [Filosofía de Testing](#filosofía-de-testing)
3. [Tipos de Tests](#tipos-de-tests)
4. [Testing con Bloc/Cubit](#testing-con-bloc-cubit)
5. [Metodología AAA](#metodología-aaa)
6. [Herramientas](#herramientas)
7. [Buenas Prácticas](#buenas-prácticas)
8. [Ejemplos Prácticos](#ejemplos-prácticos)
9. [Comandos Útiles](#comandos-útiles)
10. [Métricas de Calidad](#métricas-de-calidad)

---

## 🎯 ¿Por Qué Testear?

### 1. **Prevención de Regresiones**
Los tests detectan automáticamente cuando un cambio en el código rompe funcionalidades existentes.

```dart
// Sin tests: Cambias código → Verificas manualmente → Puede que olvides algo
// Con tests: Cambias código → Ejecutas tests → Te dice exactamente qué rompiste
```

### 2. **Documentación Viva**
Los tests son la mejor documentación porque:
- Muestran ejemplos reales de uso
- Siempre están actualizados (si el código cambia, el test falla)
- Son ejecutables (puedes correrlos para ver cómo funciona algo)

### 3. **Diseño Mejor**
Si es difícil testear tu código, probablemente el diseño está mal:
- Demasiadas dependencias
- Acoplamiento alto
- Responsabilidades no claras

### 4. **Confianza para Refactorizar**
Con tests completos puedes refactorizar sin miedo:
```dart
// Antes: "No toco este código porque no sé qué puede romperse"
// Con tests: "Refactorizo, ejecuto tests, todo verde ✅"
```

### 5. **Desarrollo Más Rápido a Largo Plazo**
- Primer sprint: Tests parecen lentos
- Tercer sprint: Empiezas a ver el valor
- Sexto sprint: No puedes vivir sin ellos

---

## 🧠 Filosofía de Testing

### El Mindset Correcto

#### ❌ Mindset Incorrecto:
```
"Los tests son una pérdida de tiempo"
"Ya probé que funciona, no necesito tests"
"Solo los perfeccionistas escriben tests"
"Los tests hacen que el desarrollo sea más lento"
```

#### ✅ Mindset Correcto:
```
"Los tests son una inversión, no un gasto"
"Los tests me dan confianza para mover rápido"
"Los tests me hacen un mejor programador"
"Los tests son parte del código, no algo extra"
```

### El Ciclo Virtuoso del Testing

```
┌─────────────────────────────────────────────┐
│  1. Escribo Test                            │
│     ↓                                       │
│  2. Test falla (Red) 🔴                     │
│     ↓                                       │
│  3. Implemento código mínimo                │
│     ↓                                       │
│  4. Test pasa (Green) 🟢                    │
│     ↓                                       │
│  5. Refactorizo con confianza               │
│     ↓                                       │
│  6. Tests siguen pasando ✅                 │
└─────────────────────────────────────────────┘
```

---

## 📊 Tipos de Tests

### 1. **Unit Tests (Tests Unitarios)** 🔬
Testean una unidad de código aislada (función, clase, método).

**Características:**
- Rápidos (milisegundos)
- Aislados (usan mocks)
- Muchos (70% de tus tests)

**Ejemplo:**
```dart
test('suma dos números correctamente', () {
  final resultado = suma(2, 3);
  expect(resultado, 5);
});
```

### 2. **Widget Tests** 🎨
Testean widgets de Flutter de forma aislada.

**Características:**
- Medio rápidos (segundos)
- Verifican UI sin dispositivo real
- Moderados (20% de tus tests)

**Ejemplo:**
```dart
testWidgets('botón muestra texto correcto', (tester) async {
  await tester.pumpWidget(MyButton());
  expect(find.text('Presionar'), findsOneWidget);
});
```

### 3. **Integration Tests (Tests de Integración)** 🔗
Testean el flujo completo de la aplicación.

**Características:**
- Lentos (minutos)
- Requieren dispositivo/emulador
- Pocos (10% de tus tests)

**Ejemplo:**
```dart
testWidgets('flujo completo de login', (tester) async {
  // 1. Abrir app
  // 2. Ingresar credenciales
  // 3. Presionar login
  // 4. Verificar que llegó a home
});
```

### La Pirámide de Testing

```
        /\
       /  \  Integration Tests (10%)
      /    \
     /------\  Widget Tests (20%)
    /        \
   /----------\  Unit Tests (70%)
  /____________\
```

---

## 🎭 Testing con Bloc/Cubit

### ¿Qué Testear en un Cubit?

#### 1. **Estado Inicial**
```dart
test('debe inicializarse con estado correcto', () {
  final cubit = MyCubit();
  expect(cubit.state, InitialState());
});
```

#### 2. **Emisión de Estados**
```dart
blocTest<MyCubit, MyState>(
  'emite [Loading, Success] cuando la operación es exitosa',
  build: () => MyCubit(),
  act: (cubit) => cubit.fetchData(),
  expect: () => [
    LoadingState(),
    SuccessState(data: expectedData),
  ],
);
```

#### 3. **Manejo de Errores**
```dart
blocTest<MyCubit, MyState>(
  'emite [Loading, Error] cuando falla',
  build: () {
    when(() => mockRepository.getData())
        .thenThrow(Exception('Error'));
    return MyCubit(repository: mockRepository);
  },
  act: (cubit) => cubit.fetchData(),
  expect: () => [
    LoadingState(),
    ErrorState(message: 'Error'),
  ],
);
```

#### 4. **Interacción con Dependencias**
```dart
blocTest<MyCubit, MyState>(
  'llama al repository correctamente',
  build: () => MyCubit(repository: mockRepository),
  act: (cubit) => cubit.fetchData(),
  verify: (_) {
    verify(() => mockRepository.getData()).called(1);
  },
);
```

---

## 🔄 Metodología AAA (Arrange-Act-Assert)

### Estructura de Todo Test

```dart
test('descripción clara de lo que testea', () {
  // ARRANGE (Preparar)
  // Configura el contexto, crea mocks, datos de prueba
  final cubit = MyCubit();
  final expectedData = [1, 2, 3];
  
  // ACT (Actuar)
  // Ejecuta la acción que quieres testear
  cubit.loadData();
  
  // ASSERT (Afirmar)
  // Verifica que el resultado es el esperado
  expect(cubit.state, LoadedState(data: expectedData));
});
```

### Ejemplo Completo con Bloc

```dart
blocTest<PlaceCubit, PlaceState>(
  'descripción del comportamiento',
  
  // ============ ARRANGE ============
  build: () {
    // 1. Crear mocks
    final mockRepository = MockPlaceRepository();
    
    // 2. Configurar comportamiento de mocks
    when(() => mockRepository.getPlaces())
        .thenAnswer((_) async => testPlaces);
    
    // 3. Crear el cubit con las dependencias
    return PlaceCubit(repository: mockRepository);
  },
  
  // ============ ACT ============
  act: (cubit) => cubit.loadPlaces(),
  
  // ============ ASSERT ============
  expect: () => [
    LoadingState(),
    LoadedState(places: testPlaces),
  ],
  
  // Verificación adicional (opcional)
  verify: (_) {
    verify(() => mockRepository.getPlaces()).called(1);
  },
);
```

---

## 🛠️ Herramientas

### 1. **flutter_test**
Framework base de testing de Flutter.

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
```

### 2. **bloc_test**
Paquete especializado para testear Blocs y Cubits.

```yaml
dev_dependencies:
  bloc_test: ^10.0.0
```

**Funciones principales:**
- `blocTest()`: Crea tests para Blocs/Cubits
- `build`: Construye el Bloc/Cubit
- `act`: Ejecuta la acción
- `expect`: Verifica estados emitidos
- `verify`: Verifica llamadas a dependencias

### 3. **mocktail**
Librería para crear mocks (objetos falsos para testing).

```yaml
dev_dependencies:
  mocktail: ^1.0.0
```

**Uso básico:**
```dart
// 1. Crear clase mock
class MockRepository extends Mock implements Repository {}

// 2. Instanciar
final mockRepo = MockRepository();

// 3. Configurar comportamiento
when(() => mockRepo.getData())
    .thenAnswer((_) async => testData);

// 4. Verificar llamadas
verify(() => mockRepo.getData()).called(1);
```

### 4. **Matchers**
Verificadores flexibles para assertions.

```dart
// Exacto
expect(actual, 5);

// Tipo
expect(actual, isA<MyClass>());

// Lista
expect(actual, isEmpty);
expect(actual, hasLength(3));

// String
expect(actual, contains('texto'));
expect(actual, startsWith('hola'));

// Combinación
expect(actual, isA<MyClass>()
    .having((obj) => obj.name, 'name', 'Juan')
    .having((obj) => obj.age, 'age', greaterThan(18))
);
```

---

## ✅ Buenas Prácticas

### 1. **Un Test, Una Cosa**

❌ **Mal:**
```dart
test('cubit funciona correctamente', () {
  cubit.loadData();
  expect(cubit.state, isA<LoadedState>());
  
  cubit.deleteData(1);
  expect(cubit.state, isA<DeletedState>());
  
  cubit.updateData(2, 'nuevo');
  expect(cubit.state, isA<UpdatedState>());
});
```

✅ **Bien:**
```dart
test('loadData emite LoadedState', () {
  cubit.loadData();
  expect(cubit.state, isA<LoadedState>());
});

test('deleteData emite DeletedState', () {
  cubit.deleteData(1);
  expect(cubit.state, isA<DeletedState>());
});

test('updateData emite UpdatedState', () {
  cubit.updateData(2, 'nuevo');
  expect(cubit.state, isA<UpdatedState>());
});
```

### 2. **Nombres Descriptivos**

❌ **Mal:**
```dart
test('test1', () { ... });
test('funciona', () { ... });
test('error', () { ... });
```

✅ **Bien:**
```dart
test('debe inicializarse con PlacesInitial', () { ... });
blocTest('emits [Loading, Loaded] cuando getPlaces es exitoso', ...);
blocTest('emits [Loading, Error] cuando getPlaces falla', ...);
```

### 3. **Tests Independientes**

❌ **Mal:**
```dart
// Test 1 modifica estado global
test('test1', () {
  globalCounter = 5;
});

// Test 2 depende del estado del test 1
test('test2', () {
  expect(globalCounter, 5); // Falla si test1 no se ejecutó
});
```

✅ **Bien:**
```dart
test('test1', () {
  final counter = 5;
  expect(counter, 5);
});

test('test2', () {
  final counter = 10;
  expect(counter, 10);
});
```

### 4. **Usa setUp y tearDown**

```dart
group('MyCubit', () {
  late MyCubit cubit;
  late MockRepository mockRepository;
  
  // Se ejecuta ANTES de cada test
  setUp(() {
    mockRepository = MockRepository();
    cubit = MyCubit(repository: mockRepository);
  });
  
  // Se ejecuta DESPUÉS de cada test
  tearDown(() {
    cubit.close(); // Evita memory leaks
  });
  
  test('...', () {
    // cubit ya está inicializado aquí
  });
});
```

### 5. **No Testees Implementación, Testea Comportamiento**

❌ **Mal:** Testear detalles internos
```dart
test('debe llamar _privateMethod', () {
  // Testeando un método privado
  expect(cubit._privateMethod(), true);
});
```

✅ **Bien:** Testear comportamiento público
```dart
test('debe emitir estado correcto cuando se carga', () {
  cubit.load();
  expect(cubit.state, isA<LoadedState>());
});
```

### 6. **Mockea Dependencias Externas**

Siempre mockea:
- 🌐 APIs (HTTP requests)
- 💾 Bases de datos
- 📁 Sistema de archivos
- 🕐 Tiempo (DateTime.now())
- 🎲 Aleatoriedad (Random)

```dart
// Mockear DateTime
class MockDateTimeProvider extends Mock implements DateTimeProvider {}

when(() => mockDateTime.now())
    .thenReturn(DateTime(2024, 1, 1));
```

### 7. **Verifica Estados en Orden**

```dart
blocTest<PlaceCubit, PlaceState>(
  'emite estados en el orden correcto',
  build: () => cubit,
  act: (cubit) => cubit.loadPlaces(),
  expect: () => [
    PlaceState.loading(),     // ✅ Primero loading
    PlaceState.loaded(...),   // ✅ Luego loaded
  ],
);
```

---

## 💡 Ejemplos Prácticos

### Ejemplo 1: Test Simple de Estado Inicial

```dart
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PlaceCubit', () {
    test('debe inicializarse con PlacesInitial', () {
      // ARRANGE
      final cubit = PlaceCubit(
        getPlacesUseCase: mockUseCase,
      );
      
      // ASSERT
      expect(cubit.state, const PlaceState.initial());
      
      // CLEANUP
      cubit.close();
    });
  });
}
```

### Ejemplo 2: Test de Caso de Éxito

```dart
blocTest<PlaceCubit, PlaceState>(
  'emits [Loading, Loaded] cuando getPlaces es exitoso',
  
  build: () {
    final testPlaces = [
      Place(id: '1', name: 'Restaurante Test', ...),
      Place(id: '2', name: 'Café Test', ...),
    ];
    
    when(() => mockGetPlacesUseCase.call(any()))
        .thenAnswer((_) async => testPlaces);
    
    return PlaceCubit(getPlacesUseCase: mockGetPlacesUseCase);
  },
  
  act: (cubit) => cubit.getPlaces(),
  
  expect: () => [
    const PlaceState.loading(),
    isA<PlacesLoaded>()
        .having((s) => s.places.length, 'places count', 2)
        .having((s) => s.places.first.name, 'first place name', 'Restaurante Test'),
  ],
  
  verify: (_) {
    verify(() => mockGetPlacesUseCase.call(any())).called(1);
  },
);
```

### Ejemplo 3: Test de Manejo de Errores

```dart
blocTest<PlaceCubit, PlaceState>(
  'emits [Loading, Error] cuando getPlaces falla',
  
  build: () {
    // Configuramos el mock para que lance una excepción
    when(() => mockGetPlacesUseCase.call(any()))
        .thenThrow(Exception('No hay conexión a Internet'));
    
    return PlaceCubit(getPlacesUseCase: mockGetPlacesUseCase);
  },
  
  act: (cubit) => cubit.getPlaces(),
  
  expect: () => [
    const PlaceState.loading(),
    isA<PlacesError>()
        .having((s) => s.error, 'error message', contains('No hay conexión')),
  ],
);
```

### Ejemplo 4: Test de Lista Vacía

```dart
blocTest<PlaceCubit, PlaceState>(
  'maneja correctamente cuando no hay lugares',
  
  build: () {
    when(() => mockGetPlacesUseCase.call(any()))
        .thenAnswer((_) async => []); // Lista vacía
    
    return PlaceCubit(getPlacesUseCase: mockGetPlacesUseCase);
  },
  
  act: (cubit) => cubit.getPlaces(),
  
  expect: () => [
    const PlaceState.loading(),
    isA<PlacesLoaded>()
        .having((s) => s.places, 'places', isEmpty),
  ],
);
```

### Ejemplo 5: Test de Múltiples Llamadas

```dart
blocTest<PlaceCubit, PlaceState>(
  'puede llamar getPlaces múltiples veces',
  
  build: () {
    when(() => mockGetPlacesUseCase.call(any()))
        .thenAnswer((_) async => testPlaces);
    
    return PlaceCubit(getPlacesUseCase: mockGetPlacesUseCase);
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

---

## 🚀 Comandos Útiles

### Ejecutar Todos los Tests
```bash
flutter test
```

### Ejecutar Test Específico
```bash
flutter test test/places/cubit/places_cubit_test.dart
```

### Ejecutar con Cobertura
```bash
flutter test --coverage
```

### Ver Reporte de Cobertura (HTML)
```bash
# Instalar lcov primero
brew install lcov

# Generar reporte HTML
genhtml coverage/lcov.info -o coverage/html

# Abrir en navegador
open coverage/html/index.html
```

### Ejecutar en Modo Watch (Re-ejecuta al guardar)
```bash
# Instalar primero
dart pub global activate test_runner

# Ejecutar
test_runner --watch
```

### Ejecutar con Logs Detallados
```bash
flutter test --verbose
```

### Ejecutar Tests que Contengan un Nombre
```bash
flutter test --name "Loading"
# Ejecuta solo tests que contengan "Loading" en el nombre
```

---

## 📈 Métricas de Calidad

### 1. **Cobertura de Código (Code Coverage)**

**¿Qué es?**
Porcentaje del código que es ejecutado por los tests.

**Niveles:**
- 🔴 < 60%: Pobre
- 🟡 60-80%: Aceptable
- 🟢 80-100%: Excelente

**Ver cobertura:**
```bash
flutter test --coverage
```

### 2. **Tipos de Cobertura**

```dart
class Calculator {
  int sum(int a, int b) {        // Línea 1
    if (a < 0 || b < 0) {        // Línea 2
      throw Exception('Solo positivos'); // Línea 3
    }
    return a + b;                // Línea 4
  }
}

// Test solo con números positivos
test('suma positivos', () {
  expect(Calculator().sum(2, 3), 5);
});

// Cobertura: 75% (ejecuta líneas 1, 2, 4 pero NO línea 3)
```

### 3. **Test Success Rate (TSR)**
Porcentaje de tests que pasan.

**Meta:** 100% siempre

```bash
# Si 98/100 tests pasan:
TSR = 98% ❌ No aceptable
# Arregla los 2 tests que fallan
```

### 4. **Test Execution Time**
Tiempo que tardan en ejecutarse los tests.

**Metas:**
- Unit tests: < 1 segundo total
- Widget tests: < 10 segundos total
- Integration tests: < 1 minuto total

### 5. **Test Flakiness**
Tests que a veces pasan y a veces fallan (sin cambios en código).

**Causas comunes:**
- Dependencias externas no mockeadas
- Condiciones de carrera (race conditions)
- Dependencias de tiempo
- Estado compartido entre tests

**Meta:** 0% flakiness

---

## 🎓 Conclusiones Clave

### Los 10 Mandamientos del Testing

1. **Testearás tu lógica de negocio**
   - Todo Cubit/Bloc debe tener tests

2. **Mockearás las dependencias externas**
   - APIs, DB, filesystem, etc.

3. **Un test testeará una cosa**
   - Un comportamiento por test

4. **Nombres descriptivos usarás**
   - El nombre debe explicar qué se testea

5. **AAA seguirás** (Arrange-Act-Assert)
   - Estructura clara en cada test

6. **Rápidos serán tus tests**
   - Tests lentos = tests que nadie ejecuta

7. **Independientes serán**
   - No dependencias entre tests

8. **setUp y tearDown usarás**
   - Código de inicialización/limpieza centralizado

9. **Comportamiento testearás, no implementación**
   - Tests deben sobrevivir refactoring

10. **En CI ejecutarás**
    - Tests automáticos en cada commit/PR

### El Valor Real del Testing

```
Sin Tests:
┌─────────────┐
│ Desarrollo  │ ██████ (Rápido al inicio)
│ Bug Fixing  │ ████████████████ (Lento después)
│ Confianza   │ █ (Baja siempre)
└─────────────┘

Con Tests:
┌─────────────┐
│ Desarrollo  │ ████████ (Un poco más lento al inicio)
│ Bug Fixing  │ ██ (Muy rápido)
│ Confianza   │ ████████████ (Alta)
│ Refactoring │ ████████████ (Seguro)
└─────────────┘
```

### Recuerda

> "Code without tests is broken by design."
> — Jacob Kaplan-Moss

> "Tests are the programmer's stone, and gold is cheaper than code."
> — James O. Coplien

> "Testing shows the presence, not the absence of bugs."
> — Edsger W. Dijkstra

---

## 📚 Recursos Adicionales

### Documentación Oficial
- [Flutter Testing Guide](https://docs.flutter.dev/testing)
- [Bloc Testing](https://bloclibrary.dev/#/testing)
- [Mocktail Documentation](https://pub.dev/packages/mocktail)

### Libros
- "Test-Driven Development" - Kent Beck
- "Growing Object-Oriented Software, Guided by Tests" - Steve Freeman

### Artículos
- [Testing Best Practices](https://flutter.dev/docs/cookbook/testing)
- [Unit Testing with Bloc](https://bloclibrary.dev/#/testing)

---

## 🎯 Próximos Pasos

1. ✅ Ejecuta los tests existentes
2. ✅ Añade tests para nuevas features
3. ✅ Aumenta la cobertura gradualmente
4. ✅ Implementa tests en CI/CD
5. ✅ Revisa tests en code reviews

**¡Happy Testing! 🚀**

