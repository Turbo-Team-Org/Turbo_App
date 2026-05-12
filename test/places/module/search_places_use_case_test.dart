import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:turbo/places/module/params/search_places_params.dart';
import 'package:turbo/places/module/search_places_use_case.dart';

class MockPlaceRepository extends Mock implements PlaceRepository {}

void main() {
  late MockPlaceRepository repository;

  setUp(() {
    repository = MockPlaceRepository();
  });

  group('SearchPlacesUseCase family', () {
    test('SearchPlacesUseCase retorna lista vacia (fallback actual)', () async {
      final useCase = SearchPlacesUseCase(placeRepository: repository);
      final result = await useCase(const SearchPlacesParams(query: 'pizza'));

      expect(result, isEmpty);
    });

    test(
      'SearchPlacesByVoiceUseCase retorna lista vacia (fallback actual)',
      () async {
        final useCase = SearchPlacesByVoiceUseCase(placeRepository: repository);
        final result = await useCase(
          const SearchPlacesParams(query: 'restaurante en habana'),
        );

        expect(result, isEmpty);
      },
    );

    test('SearchPlacesByLocationUseCase falla si falta location', () async {
      final useCase = SearchPlacesByLocationUseCase(placeRepository: repository);

      await expectLater(
        () => useCase(const SearchPlacesParams(query: 'cafe')),
        throwsA(
          predicate(
            (e) =>
                e is Exception &&
                e.toString().contains('Error al buscar lugares por ubicación'),
          ),
        ),
      );
    });

    test('SearchPlacesByLocationUseCase retorna lista vacia con location', () async {
      final useCase = SearchPlacesByLocationUseCase(placeRepository: repository);

      final result = await useCase(
        const SearchPlacesParams(
          query: 'cafe',
          location: LatLng(23.1136, -82.3666),
          maxDistance: 1000,
        ),
      );

      expect(result, isEmpty);
    });
  });
}
