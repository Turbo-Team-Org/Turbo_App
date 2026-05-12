import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:turbo/places/module/get_places_by_location_use_case.dart';
import 'package:turbo/places/module/params/search_places_params.dart';

class MockLocationRepository extends Mock implements LocationRepository {}

class MockPlaceRepository extends Mock implements PlaceRepository {}

Place _place({
  required String id,
  required String categoryId,
  required double rating,
  required double avgPrice,
  required double lat,
  required double lng,
}) {
  return Place(
    id: id,
    name: id,
    description: 'desc $id',
    address: 'addr $id',
    averagePrice: avgPrice,
    imageUrls: const [],
    rating: rating,
    reviews: const [],
    categoryId: categoryId,
    latitude: lat,
    longitude: lng,
  );
}

void main() {
  late MockLocationRepository locationRepository;
  late MockPlaceRepository placeRepository;
  late GetPlacesByLocationUseCase useCase;

  setUpAll(() {
    registerFallbackValue(
      LocationData(
        latitude: 23.1136,
        longitude: -82.3666,
        timestamp: DateTime(2026, 1, 1),
      ),
    );
  });

  setUp(() {
    locationRepository = MockLocationRepository();
    placeRepository = MockPlaceRepository();
    useCase = GetPlacesByLocationUseCase(
      locationRepository: locationRepository,
      placeRepository: placeRepository,
    );
  });

  test('filtra por radio/categoría/rating/precio y aplica limit', () async {
    final places = [
      _place(
        id: 'p1',
        categoryId: 'food',
        rating: 4.8,
        avgPrice: 20,
        lat: 23.11,
        lng: -82.36,
      ),
      _place(
        id: 'p2',
        categoryId: 'food',
        rating: 4.6,
        avgPrice: 30,
        lat: 23.12,
        lng: -82.35,
      ),
      _place(
        id: 'p3',
        categoryId: 'hotel',
        rating: 4.9,
        avgPrice: 50,
        lat: 23.13,
        lng: -82.34,
      ),
    ];

    when(() => locationRepository.findPlacesWithinRadius(
          center: any(named: 'center'),
          radiusMeters: any(named: 'radiusMeters'),
          categories: any(named: 'categories'),
          limit: any(named: 'limit'),
          sortBy: any(named: 'sortBy'),
        )).thenThrow(Exception('fallback manual'));
    when(() => placeRepository.getPlaces()).thenAnswer((_) async => places);
    when(() => locationRepository.calculateDistanceHaversine(
          lat1: any(named: 'lat1'),
          lon1: any(named: 'lon1'),
          lat2: any(named: 'lat2'),
          lon2: any(named: 'lon2'),
        )).thenAnswer((invocation) {
      final lat2 = invocation.namedArguments[#lat2] as double;
      if (lat2 == 23.11) return 100.0;
      if (lat2 == 23.12) return 200.0;
      return 9000.0;
    });

    final result = await useCase(
      const GetPlacesByLocationParams(
        location: LatLng(23.1136, -82.3666),
        radius: 5000,
        categoryId: 'food',
        minRating: 4.5,
        minPrice: 10,
        maxPrice: 40,
        limit: 1,
        sortBy: 'distance',
      ),
    );

    expect(result.length, 1);
    expect(result.first.id, 'p1');
  });

  test('ordena por rating cuando sortBy = rating', () async {
    final places = [
      _place(
        id: 'low',
        categoryId: 'food',
        rating: 3.2,
        avgPrice: 10,
        lat: 23.11,
        lng: -82.36,
      ),
      _place(
        id: 'high',
        categoryId: 'food',
        rating: 4.9,
        avgPrice: 12,
        lat: 23.12,
        lng: -82.35,
      ),
    ];

    when(() => locationRepository.findPlacesWithinRadius(
          center: any(named: 'center'),
          radiusMeters: any(named: 'radiusMeters'),
          categories: any(named: 'categories'),
          limit: any(named: 'limit'),
          sortBy: any(named: 'sortBy'),
        )).thenThrow(Exception('fallback manual'));
    when(() => placeRepository.getPlaces()).thenAnswer((_) async => places);
    when(() => locationRepository.calculateDistanceHaversine(
          lat1: any(named: 'lat1'),
          lon1: any(named: 'lon1'),
          lat2: any(named: 'lat2'),
          lon2: any(named: 'lon2'),
        )).thenReturn(100);

    final result = await useCase(
      const GetPlacesByLocationParams(
        location: LatLng(23.1136, -82.3666),
        sortBy: 'rating',
      ),
    );

    expect(result.first.id, 'high');
    expect(result.last.id, 'low');
  });

  test('propaga error tipado cuando falla el flujo', () async {
    when(() => locationRepository.findPlacesWithinRadius(
          center: any(named: 'center'),
          radiusMeters: any(named: 'radiusMeters'),
          categories: any(named: 'categories'),
          limit: any(named: 'limit'),
          sortBy: any(named: 'sortBy'),
        )).thenThrow(Exception('nearby fail'));
    when(() => placeRepository.getPlaces()).thenThrow(Exception('db fail'));

    await expectLater(
      () => useCase(
        const GetPlacesByLocationParams(location: LatLng(23.1136, -82.3666)),
      ),
      throwsA(
        predicate(
          (e) =>
              e is Exception &&
              e.toString().contains('Error al obtener lugares por ubicación'),
        ),
      ),
    );
  });
}
