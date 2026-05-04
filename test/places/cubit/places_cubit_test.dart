import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:turbo/places/state_management/place_bloc/cubit/place_cubit.dart';
import 'package:turbo/places/module/get_places_use_case.dart';
import 'package:turbo/categories/module/get_places_by_category_use_case.dart';
import 'package:turbo/app/core/no_params.dart';
import 'package:mocktail/mocktail.dart';
import 'package:core/core.dart';

// ============================================================================
// FILOSOFÍA DE TESTING CON BLOC/CUBIT
// ============================================================================
//
// 1. ¿POR QUÉ TESTEAR?
//    - Prevenir regresiones: Los tests detectan bugs cuando modificas código
//    - Documentación viva: Los tests muestran cómo usar tu código
//    - Diseño mejor: Si es difícil testear, el diseño probablemente está mal
//    - Confianza: Puedes refactorizar sin miedo a romper cosas
//
// 2. ¿QUÉ TESTEAR EN UN CUBIT?
//    - Estado inicial correcto
//    - Emisión de estados en el orden correcto
//    - Manejo de casos de éxito
//    - Manejo de casos de error
//    - Interacción con dependencias (use cases, repositories)
//
// 3. METODOLOGÍA AAA (Arrange-Act-Assert):
//    - ARRANGE: Prepara el contexto (mocks, datos de prueba)
//    - ACT: Ejecuta la acción que quieres testear
//    - ASSERT: Verifica que el resultado es el esperado
//
// ============================================================================

// MOCKS: Simulan el comportamiento de las dependencias reales
class MockGetPlacesUseCase extends Mock implements GetPlacesUseCase {}

class MockGetPlacesByCategoryUseCase extends Mock
    implements GetPlacesByCategoryUseCase {}

void main() {
  // Registrar fallback values para mocktail
  setUpAll(() {
    registerFallbackValue(NoParams());
  });

  group('PlaceCubit Tests Completos', () {
    // Variables que se usarán en todos los tests
    late PlaceCubit cubit;
    late MockGetPlacesUseCase mockGetPlacesUseCase;
    late MockGetPlacesByCategoryUseCase mockGetPlacesByCategoryUseCase;

    // setUp se ejecuta ANTES de cada test
    setUp(() {
      mockGetPlacesUseCase = MockGetPlacesUseCase();
      mockGetPlacesByCategoryUseCase = MockGetPlacesByCategoryUseCase();
      cubit = PlaceCubit(
        getPlacesUseCase: mockGetPlacesUseCase,
        getPlacesByCategoryUseCase: mockGetPlacesByCategoryUseCase,
      );
    });

    // tearDown se ejecuta DESPUÉS de cada test
    tearDown(() {
      cubit.close();
    });

    // ========================================================================
    // TEST 1: Estado Inicial
    // ========================================================================
    test('debe inicializarse con PlacesInitial', () {
      // ASSERT: Verificamos que el estado inicial es correcto
      expect(cubit.state, const PlaceState.initial());
    });

    // ========================================================================
    // TEST 2: Caso de Éxito - getPlaces()
    // ========================================================================
    blocTest<PlaceCubit, PlaceState>(
      'emits [PlacesLoading, PlacesLoaded] cuando getPlaces() es exitoso',
      // ARRANGE: Preparamos datos de prueba
      build: () {
        // Creamos lugares de prueba con el modelo Place actualizado
        final testPlaces = [
          Place(
            id: '1',
            name: 'Restaurante Test',
            description: 'Descripción test',
            address: 'Calle Test 123',
            averagePrice: 25.0,
            imageUrls: const ['image1.jpg'],
            rating: 4.5,
            reviews: const [],
            categoryId: 'cat1',
            latitude: 0.0,
            longitude: 0.0,
          ),
          Place(
            id: '2',
            name: 'Café Test',
            description: 'Café de prueba',
            address: 'Avenida Test 456',
            averagePrice: 15.0,
            imageUrls: const ['image2.jpg'],
            rating: 4.0,
            reviews: const [],
            categoryId: 'cat2',
            latitude: 0.0,
            longitude: 0.0,
          ),
        ];

        // Configuramos el mock para que devuelva nuestros datos de prueba
        when(() => mockGetPlacesUseCase.call(any()))
            .thenAnswer((_) async => testPlaces);

        return cubit;
      },
      // ACT: Ejecutamos la acción
      act: (cubit) => cubit.getPlaces(),
      // ASSERT: Verificamos la secuencia de estados emitidos
      expect: () => [
        const PlaceState.loading(), // Primero emite loading
        isA<PlacesLoaded>() // Luego emite loaded con los places
            .having(
              (state) => state.places.length,
              'número de places',
              2, // Verificamos que hay 2 lugares
            )
            .having(
              (state) => state.places.first.name,
              'primer place name',
              'Restaurante Test',
            ),
      ],
      // Verificamos que el use case fue llamado correctamente
      verify: (_) {
        verify(() => mockGetPlacesUseCase.call(any())).called(1);
      },
    );

    // ========================================================================
    // TEST 3: Caso de Error - getPlaces()
    // ========================================================================
    blocTest<PlaceCubit, PlaceState>(
      'emits [PlacesLoading, PlacesError] cuando getPlaces() falla',
      // ARRANGE: Configuramos el mock para que lance una excepción
      build: () {
        when(() => mockGetPlacesUseCase.call(any()))
            .thenThrow(Exception('Error al obtener lugares'));
        return cubit;
      },
      // ACT: Ejecutamos la acción
      act: (cubit) => cubit.getPlaces(),
      // ASSERT: Verificamos que se emite el estado de error
      expect: () => [
        const PlaceState.loading(),
        isA<PlacesError>().having(
          (state) => state.error,
          'mensaje de error',
          contains('Error al obtener lugares'),
        ),
      ],
      verify: (_) {
        verify(() => mockGetPlacesUseCase.call(any())).called(1);
      },
    );

    // ========================================================================
    // TEST 4: Lista Vacía
    // ========================================================================
    blocTest<PlaceCubit, PlaceState>(
      'emits [PlacesLoading, PlacesLoaded] con lista vacía cuando no hay lugares',
      build: () {
        // Mock devuelve lista vacía
        when(() => mockGetPlacesUseCase.call(any()))
            .thenAnswer((_) async => []);
        return cubit;
      },
      act: (cubit) => cubit.getPlaces(),
      expect: () => [
        const PlaceState.loading(),
        isA<PlacesLoaded>().having(
          (state) => state.places,
          'places vacíos',
          isEmpty,
        ),
      ],
    );

    // ========================================================================
    // TEST 5: Múltiples Llamadas
    // ========================================================================
    blocTest<PlaceCubit, PlaceState>(
      'puede llamar getPlaces() múltiples veces correctamente',
      build: () {
        when(() => mockGetPlacesUseCase.call(any())).thenAnswer(
          (_) async => [
            Place(
              id: '1',
              name: 'Test Place',
              description: 'Test',
              address: 'Test Address',
              averagePrice: 20.0,
              imageUrls: const [],
              rating: 4.0,
              reviews: const [],
              categoryId: 'cat1',
              latitude: 0.0,
              longitude: 0.0,
            ),
          ],
        );
        return cubit;
      },
      act: (cubit) async {
        await cubit.getPlaces();
        await cubit.getPlaces(); // Segunda llamada
      },
      expect: () => [
        const PlaceState.loading(),
        isA<PlacesLoaded>(),
        const PlaceState.loading(), // Segunda vez
        isA<PlacesLoaded>(), // Segunda vez
      ],
      verify: (_) {
        // Verificamos que se llamó 2 veces
        verify(() => mockGetPlacesUseCase.call(any())).called(2);
      },
    );

    // ========================================================================
    // TEST 6: Error Específico de Red
    // ========================================================================
    blocTest<PlaceCubit, PlaceState>(
      'maneja correctamente errores de conexión',
      build: () {
        when(() => mockGetPlacesUseCase.call(any()))
            .thenThrow(Exception('No hay conexión a Internet'));
        return cubit;
      },
      act: (cubit) => cubit.getPlaces(),
      expect: () => [
        const PlaceState.loading(),
        isA<PlacesError>().having(
          (state) => state.error,
          'error de conexión',
          contains('No hay conexión a Internet'),
        ),
      ],
    );

    // ========================================================================
    // TEST 7: Verificar que no se emite si el cubit está cerrado
    // ========================================================================
    test('no emite estados después de close()', () async {
      // ARRANGE
      when(() => mockGetPlacesUseCase.call(any())).thenAnswer(
        (_) async => [],
      );

      // ACT: Cerramos el cubit
      await cubit.close();

      // ASSERT: Verificar que está cerrado
      expect(cubit.isClosed, true);

      // No debe emitir estados después de cerrado
      // Esto previene memory leaks
    });
  });

  // ==========================================================================
  // GRUPO 2: Tests de Integración (si quisieras testear flujos completos)
  // ==========================================================================
  group('PlaceCubit Integration Tests', () {
    late PlaceCubit cubit;
    late MockGetPlacesUseCase mockGetPlacesUseCase;
    late MockGetPlacesByCategoryUseCase mockGetPlacesByCategoryUseCase;

    setUp(() {
      mockGetPlacesUseCase = MockGetPlacesUseCase();
      mockGetPlacesByCategoryUseCase = MockGetPlacesByCategoryUseCase();
      cubit = PlaceCubit(
        getPlacesUseCase: mockGetPlacesUseCase,
        getPlacesByCategoryUseCase: mockGetPlacesByCategoryUseCase,
      );
    });

    tearDown(() {
      cubit.close();
    });

    test('el cubit mantiene el último estado después de error', () async {
      // ARRANGE: Primera llamada exitosa
      final testPlaces = [
        Place(
          id: '1',
          name: 'Test',
          description: 'Test',
          address: 'Test',
          averagePrice: 20.0,
          imageUrls: const [],
          rating: 4.0,
          reviews: const [],
          categoryId: 'cat1',
          latitude: 0.0,
          longitude: 0.0,
        ),
      ];

      when(() => mockGetPlacesUseCase.call(any()))
          .thenAnswer((_) async => testPlaces);

      // ACT: Primera llamada
      await cubit.getPlaces();

      // ASSERT: Estado es loaded
      expect(cubit.state, isA<PlacesLoaded>());

      // ARRANGE: Segunda llamada falla
      when(() => mockGetPlacesUseCase.call(any()))
          .thenThrow(Exception('Error'));

      // ACT: Segunda llamada
      await cubit.getPlaces();

      // ASSERT: Estado cambió a error
      expect(cubit.state, isA<PlacesError>());
    });
  });
}

// ============================================================================
// CONCLUSIONES Y MEJORES PRÁCTICAS
// ============================================================================
//
// 1. COBERTURA DE CÓDIGO:
//    - Apunta a 80-100% de cobertura en lógica de negocio
//    - Usa: flutter test --coverage
//
// 2. NAMING CONVENTIONS:
//    - Nombres descriptivos: "emits [states] cuando [acción] [condición]"
//    - Agrupa tests relacionados con group()
//
// 3. MANTIENE TESTS RÁPIDOS:
//    - Usa mocks para dependencias externas
//    - No uses delays artificiales
//    - Tests lentos = tests que no se ejecutan
//
// 4. TESTS DEBEN SER DETERMINÍSTICOS:
//    - Siempre producen el mismo resultado
//    - No dependen de orden de ejecución
//    - No dependen de estado externo
//
// ============================================================================
