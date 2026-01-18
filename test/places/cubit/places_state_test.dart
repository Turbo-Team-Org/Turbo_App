import 'package:flutter_test/flutter_test.dart';
import 'package:turbo/places/state_management/place_bloc/cubit/place_cubit.dart';
import 'package:core/core.dart';

// ============================================================================
// TESTS DE ESTADO (PlaceState)
// ============================================================================
//
// Los tests de estado verifican que:
// 1. Los estados se pueden crear correctamente
// 2. La igualdad funciona (importante para Freezed)
// 3. Los estados son inmutables
// 4. Pattern matching de Dart 3 funciona correctamente
//
// Estos tests son importantes aunque parezcan simples porque:
// - Verifican que Freezed generó el código correctamente
// - Documentan qué propiedades tiene cada estado
// - Detectan cambios accidentales en los estados
// ============================================================================

void main() {
  group('PlaceState Tests', () {
    // ========================================================================
    // TEST 1: PlacesInitial
    // ========================================================================
    group('PlacesInitial', () {
      test('se puede crear', () {
        const state = PlaceState.initial();
        expect(state, isA<PlacesInitial>());
      });

      test('dos instancias son iguales (equality)', () {
        const state1 = PlaceState.initial();
        const state2 = PlaceState.initial();
        expect(state1, state2);
      });

      test('toString retorna información útil', () {
        const state = PlaceState.initial();
        expect(state.toString(), contains('initial'));
      });
    });

    // ========================================================================
    // TEST 2: PlacesLoading
    // ========================================================================
    group('PlacesLoading', () {
      test('se puede crear', () {
        const state = PlaceState.loading();
        expect(state, isA<PlacesLoading>());
      });

      test('dos instancias son iguales', () {
        const state1 = PlaceState.loading();
        const state2 = PlaceState.loading();
        expect(state1, state2);
      });

      test('es diferente de PlacesInitial', () {
        const state1 = PlaceState.initial();
        const state2 = PlaceState.loading();
        expect(state1, isNot(state2));
      });

      test('toString retorna información útil', () {
        const state = PlaceState.loading();
        expect(state.toString(), contains('loading'));
      });
    });

    // ========================================================================
    // TEST 3: PlacesLoaded
    // ========================================================================
    group('PlacesLoaded', () {
      // Helper para crear places de prueba con el modelo actualizado
      List<Place> createTestPlaces() => [
            Place(
              id: '1',
              name: 'Restaurante Test',
              description: 'Descripción test',
              address: 'Calle Test 123',
              averagePrice: 25.0,
              imageUrls: const ['image1.jpg', 'image2.jpg'],
              rating: 4.5,
              reviews: const [],
              categoryId: 'cat1',
              latitude: 40.4168,
              longitude: -3.7038,
              tags: const ['wifi', 'parking', 'accesible'],
              phone: '123456789',
              website: 'https://test.com',
            ),
            Place(
              id: '2',
              name: 'Café Test',
              description: 'Café de prueba',
              address: 'Avenida Test 456',
              averagePrice: 15.0,
              imageUrls: const ['cafe.jpg'],
              rating: 4.0,
              reviews: const [],
              categoryId: 'cat2',
              latitude: 40.4169,
              longitude: -3.7039,
              tags: const ['wifi'],
              phone: '987654321',
            ),
          ];

      test('se puede crear con lista de places', () {
        final testPlaces = createTestPlaces();
        final state = PlaceState.loaded(places: testPlaces);
        expect(state, isA<PlacesLoaded>());
      });

      test('contiene los places correctamente', () {
        final testPlaces = createTestPlaces();
        final state = PlaceState.loaded(places: testPlaces);

        expect(state, isA<PlacesLoaded>());
        final loadedState = state as PlacesLoaded;

        expect(loadedState.places, hasLength(2));
        expect(loadedState.places.first.name, 'Restaurante Test');
        expect(loadedState.places.last.name, 'Café Test');
      });

      test('se puede crear con lista vacía', () {
        const state = PlaceState.loaded(places: []);

        expect(state, isA<PlacesLoaded>());
        final loadedState = state as PlacesLoaded;

        expect(loadedState.places, isEmpty);
      });

      test('dos instancias con mismos places son iguales', () {
        final testPlaces = createTestPlaces();
        final state1 = PlaceState.loaded(places: testPlaces);
        final state2 = PlaceState.loaded(places: testPlaces);
        expect(state1, state2);
      });

      test('dos instancias con diferentes places son diferentes', () {
        final testPlaces = createTestPlaces();
        final state1 = PlaceState.loaded(places: testPlaces);
        final state2 = PlaceState.loaded(places: [testPlaces.first]);
        expect(state1, isNot(state2));
      });

      test('es diferente de otros estados', () {
        final testPlaces = createTestPlaces();
        final loadedState = PlaceState.loaded(places: testPlaces);
        const initialState = PlaceState.initial();
        const loadingState = PlaceState.loading();

        expect(loadedState, isNot(initialState));
        expect(loadedState, isNot(loadingState));
      });

      test('toString incluye información de places', () {
        final testPlaces = createTestPlaces();
        final state = PlaceState.loaded(places: testPlaces);
        final stateString = state.toString();

        expect(stateString, contains('loaded'));
        expect(stateString, contains('places'));
      });

      test('puede acceder a propiedades de places', () {
        final testPlaces = createTestPlaces();
        final state = PlaceState.loaded(places: testPlaces);
        final loadedState = state as PlacesLoaded;

        final firstPlace = loadedState.places.first;
        expect(firstPlace.name, 'Restaurante Test');
        expect(firstPlace.rating, 4.5);
        expect(firstPlace.tags, contains('wifi'));
      });
    });

    // ========================================================================
    // TEST 4: PlacesError
    // ========================================================================
    group('PlacesError', () {
      test('se puede crear con mensaje de error', () {
        const state = PlaceState.error('Error de prueba');
        expect(state, isA<PlacesError>());
      });

      test('contiene el mensaje de error correcto', () {
        const errorMessage = 'No hay conexión a Internet';
        const state = PlaceState.error(errorMessage);

        expect(state, isA<PlacesError>());
        final errorState = state as PlacesError;

        expect(errorState.error, errorMessage);
      });

      test('dos instancias con mismo error son iguales', () {
        const state1 = PlaceState.error('Error 1');
        const state2 = PlaceState.error('Error 1');
        expect(state1, state2);
      });

      test('dos instancias con diferentes errores son diferentes', () {
        const state1 = PlaceState.error('Error 1');
        const state2 = PlaceState.error('Error 2');
        expect(state1, isNot(state2));
      });

      test('es diferente de otros estados', () {
        const errorState = PlaceState.error('Error');
        const initialState = PlaceState.initial();
        const loadingState = PlaceState.loading();

        expect(errorState, isNot(initialState));
        expect(errorState, isNot(loadingState));
      });

      test('puede manejar errores vacíos', () {
        const state = PlaceState.error('');

        expect(state, isA<PlacesError>());
        final errorState = state as PlacesError;

        expect(errorState.error, isEmpty);
      });

      test('puede manejar errores largos', () {
        const longError = 'Este es un error muy largo que contiene '
            'múltiples líneas de información detallada sobre qué fue '
            'lo que salió mal en la aplicación';
        const state = PlaceState.error(longError);

        expect(state, isA<PlacesError>());
        final errorState = state as PlacesError;

        expect(errorState.error, longError);
        expect(errorState.error.length, greaterThan(50));
      });

      test('toString incluye el mensaje de error', () {
        const errorMessage = 'Test Error';
        const state = PlaceState.error(errorMessage);
        final stateString = state.toString();

        expect(stateString, contains('error'));
      });
    });

    // ========================================================================
    // TEST 5: Pattern Matching con Dart 3 (switch expression)
    // ========================================================================
    group('Pattern Matching con Dart 3', () {
      test('puede hacer pattern matching con switch expression', () {
        const state = PlaceState.initial();

        final result = switch (state) {
          PlacesInitial() => 'initial',
          PlacesLoading() => 'loading',
          PlacesLoaded() => 'loaded',
          PlacesError() => 'error',
        };

        expect(result, 'initial');
      });

      test('pattern matching con PlacesLoading', () {
        const state = PlaceState.loading();

        final result = switch (state) {
          PlacesInitial() => 'initial',
          PlacesLoading() => 'loading',
          PlacesLoaded() => 'loaded',
          PlacesError() => 'error',
        };

        expect(result, 'loading');
      });

      test('pattern matching con PlacesLoaded puede acceder a places', () {
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
        final state = PlaceState.loaded(places: testPlaces);

        final result = switch (state) {
          PlacesInitial() => 0,
          PlacesLoading() => 0,
          PlacesLoaded(:final places) => places.length,
          PlacesError() => 0,
        };

        expect(result, 1);
      });

      test('pattern matching con PlacesError devuelve mensaje', () {
        const errorMessage = 'Test Error';
        const state = PlaceState.error(errorMessage);

        final result = switch (state) {
          PlacesInitial() => '',
          PlacesLoading() => '',
          PlacesLoaded() => '',
          PlacesError(:final error) => error,
        };

        expect(result, errorMessage);
      });

      test('puede usar if-case para casos específicos', () {
        const PlaceState state = PlaceState.loading();

        final result = switch (state) {
          PlacesLoading() => 'is loading',
          _ => 'not loading',
        };

        expect(result, 'is loading');
      });

      test('if-case usa default para casos no manejados', () {
        const PlaceState state = PlaceState.initial();

        final result = switch (state) {
          PlacesLoading() => 'is loading',
          _ => 'not loading',
        };

        expect(result, 'not loading');
      });
    });

    // ========================================================================
    // TEST 6: Casos de Uso Realistas
    // ========================================================================
    group('Casos de Uso Realistas', () {
      test('puede determinar si está cargando', () {
        const PlaceState state = PlaceState.loading();

        final isLoading = state is PlacesLoading;

        expect(isLoading, true);
      });

      test('puede determinar si tiene datos', () {
        final state = PlaceState.loaded(places: [
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
        ]);

        final hasData = switch (state) {
          PlacesLoaded(:final places) => places.isNotEmpty,
          _ => false,
        };

        expect(hasData, true);
      });

      test('puede extraer mensaje de error si existe', () {
        const PlaceState state = PlaceState.error('Connection failed');

        final errorMessage = switch (state) {
          PlacesError(:final error) => error,
          _ => null,
        };

        expect(errorMessage, 'Connection failed');
      });

      test('retorna null si no hay error', () {
        const PlaceState state = PlaceState.initial();

        final errorMessage = switch (state) {
          PlacesError(:final error) => error,
          _ => null,
        };

        expect(errorMessage, isNull);
      });

      test('puede manejar estados en UI con switch', () {
        final states = [
          const PlaceState.initial(),
          const PlaceState.loading(),
          PlaceState.loaded(places: [
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
          ]),
          const PlaceState.error('Error'),
        ];

        final results = states.map((state) {
          return switch (state) {
            PlacesInitial() => 'Inicializando...',
            PlacesLoading() => 'Cargando...',
            PlacesLoaded(:final places) => 'Lugares: ${places.length}',
            PlacesError(:final error) => 'Error: $error',
          };
        }).toList();

        expect(results[0], 'Inicializando...');
        expect(results[1], 'Cargando...');
        expect(results[2], 'Lugares: 1');
        expect(results[3], 'Error: Error');
      });
    });

    // ========================================================================
    // TEST 7: CopyWith (solo disponible en estados con propiedades)
    // ========================================================================
    group('CopyWith', () {
      test('PlacesLoaded tiene copyWith', () {
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
        final state = PlaceState.loaded(places: testPlaces) as PlacesLoaded;

        final newPlace = Place(
          id: '2',
          name: 'Nuevo',
          description: 'Nuevo',
          address: 'Nuevo',
          averagePrice: 30.0,
          imageUrls: const [],
          rating: 5.0,
          reviews: const [],
          categoryId: 'cat2',
          latitude: 0.0,
          longitude: 0.0,
        );

        final newState = state.copyWith(places: [...testPlaces, newPlace]);

        expect(newState.places.length, 2);
        expect(newState.places.last.name, 'Nuevo');
      });

      test('PlacesError tiene copyWith', () {
        const state = PlaceState.error('Error original') as PlacesError;
        final newState = state.copyWith(error: 'Nuevo error');

        expect(newState.error, 'Nuevo error');
      });
    });
  });
}

// ============================================================================
// CONCLUSIONES SOBRE TESTS DE ESTADO CON DART 3
// ============================================================================
//
// 1. SEALED CLASSES:
//    - Freezed con sealed class usa pattern matching nativo de Dart 3
//    - No genera métodos when/maybeWhen/map/maybeMap
//    - Usa switch expressions en su lugar
//
// 2. PATTERN MATCHING:
//    - switch (state) { case Pattern() => ... }
//    - Puede destructurar propiedades: PlacesLoaded(:final places)
//    - El wildcard _ maneja casos no especificados
//
// 3. EQUALITY:
//    - Freezed implementa == y hashCode automáticamente
//    - Dos estados con mismo contenido son considerados iguales
//    - Importante para que Bloc no emita estados duplicados
//
// 4. INMUTABILIDAD:
//    - Los estados de Freezed son inmutables
//    - No puedes modificar un estado, debes crear uno nuevo
//    - copyWith facilita crear copias con cambios
//
// 5. BENEFICIOS DE DART 3:
//    - Pattern matching más expresivo
//    - Exhaustive checking en switch
//    - Mejor rendimiento que métodos de extensión
//
// ============================================================================
