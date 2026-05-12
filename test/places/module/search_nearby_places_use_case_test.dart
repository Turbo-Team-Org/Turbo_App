import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:turbo/places/module/params/search_places_params.dart';
import 'package:turbo/places/module/search_nearby_places_use_case.dart';

class MockLocationRepository extends Mock implements LocationRepository {}

class MockPlaceRepository extends Mock implements PlaceRepository {}

Place _place({
  required String id,
  required String categoryId,
  required String name,
  required String description,
  required String address,
  required double rating,
  required double lat,
  required double lng,
}) {
  return Place(
    id: id,
    name: name,
    description: description,
    address: address,
    averagePrice: 10,
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
  late SearchNearbyPlacesUseCase useCase;

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
    useCase = SearchNearbyPlacesUseCase(
      locationRepository: locationRepository,
      placeRepository: placeRepository,
    );
  });

  test('filtra por category + keyword + minRating y ordena por distancia', () async {
    final places = [
      _place(
        id: 'a',
        categoryId: 'food',
        name: 'Pizza Havana',
        description: 'italiana',
        address: 'Centro',
        rating: 4.8,
        lat: 23.11,
        lng: -82.36,
      ),
      _place(
        id: 'b',
        categoryId: 'food',
        name: 'Cafe Plaza',
        description: 'coffee',
        address: 'Vedado',
        rating: 3.2,
        lat: 23.12,
        lng: -82.35,
      ),
      _place(
        id: 'c',
        categoryId: 'hotel',
        name: 'Hotel',
        description: 'stay',
        address: 'Old',
        rating: 4.9,
        lat: 23.13,
        lng: -82.34,
      ),
    ];

    when(() => placeRepository.getPlaces()).thenAnswer((_) async => places);
    when(() => locationRepository.searchNearbyPlaces(
          location: any(named: 'location'),
          radius: any(named: 'radius'),
          type: any(named: 'type'),
          keyword: any(named: 'keyword'),
        )).thenThrow(Exception('google unavailable'));
    when(() => locationRepository.calculateDistanceHaversine(
          lat1: any(named: 'lat1'),
          lon1: any(named: 'lon1'),
          lat2: any(named: 'lat2'),
          lon2: any(named: 'lon2'),
        )).thenAnswer((invocation) {
      final lat2 = invocation.namedArguments[#lat2] as double;
      if (lat2 == 23.11) return 100.0;
      if (lat2 == 23.12) return 200.0;
      return 300.0;
    });

    final result = await useCase(
      const SearchNearbyPlacesParams(
        location: LatLng(23.1136, -82.3666),
        radius: 5000,
        categoryId: 'food',
        keyword: 'pizza',
        minRating: 4.0,
      ),
    );

    expect(result.length, 1);
    expect(result.first.id, 'a');
  });

  test('elimina duplicados por id y respeta limit', () async {
    final duplicateA1 = _place(
      id: 'dup',
      categoryId: 'food',
      name: 'A',
      description: 'A',
      address: 'A',
      rating: 4.5,
      lat: 23.11,
      lng: -82.36,
    );
    final duplicateA2 = _place(
      id: 'dup',
      categoryId: 'food',
      name: 'A2',
      description: 'A2',
      address: 'A2',
      rating: 4.6,
      lat: 23.12,
      lng: -82.35,
    );
    final b = _place(
      id: 'b',
      categoryId: 'food',
      name: 'B',
      description: 'B',
      address: 'B',
      rating: 4.7,
      lat: 23.13,
      lng: -82.34,
    );

    when(() => placeRepository.getPlaces())
        .thenAnswer((_) async => [duplicateA1, duplicateA2, b]);
    when(() => locationRepository.searchNearbyPlaces(
          location: any(named: 'location'),
          radius: any(named: 'radius'),
          type: any(named: 'type'),
          keyword: any(named: 'keyword'),
        )).thenThrow(Exception('google unavailable'));
    when(() => locationRepository.calculateDistanceHaversine(
          lat1: any(named: 'lat1'),
          lon1: any(named: 'lon1'),
          lat2: any(named: 'lat2'),
          lon2: any(named: 'lon2'),
        )).thenReturn(100.0);

    final result = await useCase(
      const SearchNearbyPlacesParams(
        location: LatLng(23.1136, -82.3666),
        limit: 1,
      ),
    );

    expect(result.length, 1);
    expect(result.first.id, 'dup');
  });

  test('lanza excepción tipada cuando falla repositorio local', () async {
    when(() => placeRepository.getPlaces()).thenThrow(Exception('db fail'));
    when(() => locationRepository.searchNearbyPlaces(
          location: any(named: 'location'),
          radius: any(named: 'radius'),
          type: any(named: 'type'),
          keyword: any(named: 'keyword'),
        )).thenThrow(Exception('google unavailable'));

    await expectLater(
      () => useCase(
        const SearchNearbyPlacesParams(location: LatLng(23.1136, -82.3666)),
      ),
      throwsA(
        predicate(
          (e) =>
              e is Exception &&
              e.toString().contains('Error al buscar lugares cercanos'),
        ),
      ),
    );
  });
}
