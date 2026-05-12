import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:core/core.dart';
import 'package:turbo/categories/module/get_places_by_category_use_case.dart';
import 'package:turbo/places/module/get_places_by_location_use_case.dart';
import 'package:turbo/places/module/params/search_filters_params.dart';
import 'package:turbo/places/module/params/search_places_params.dart';
import 'package:turbo/places/module/search_nearby_places_use_case.dart';
import 'package:turbo/places/module/search_places_use_case.dart';
import 'package:turbo/places/state_management/place_search_cubit/places_search_cubit.dart';

class MockGetPlacesByCategoryUseCase extends Mock
    implements GetPlacesByCategoryUseCase {}

class MockSearchPlacesUseCase extends Mock implements SearchPlacesUseCase {}

class MockSearchPlacesByVoiceUseCase extends Mock
    implements SearchPlacesByVoiceUseCase {}

class MockGetPlacesByLocationUseCase extends Mock
    implements GetPlacesByLocationUseCase {}

class MockSearchNearbyPlacesUseCase extends Mock
    implements SearchNearbyPlacesUseCase {}

Place _buildPlace({
  required String id,
  required double rating,
  List<String> imageUrls = const [],
  List<Review> reviews = const [],
}) {
  return Place(
    id: id,
    name: 'Place $id',
    description: 'desc',
    address: 'addr',
    averagePrice: 0,
    imageUrls: imageUrls,
    rating: rating,
    reviews: reviews,
  );
}

void main() {
  late PlacesSearchCubit cubit;
  late MockGetPlacesByCategoryUseCase mockGetPlacesByCategoryUseCase;
  late MockSearchPlacesUseCase mockSearchPlacesUseCase;
  late MockSearchPlacesByVoiceUseCase mockSearchPlacesByVoiceUseCase;
  late MockGetPlacesByLocationUseCase mockGetPlacesByLocationUseCase;
  late MockSearchNearbyPlacesUseCase mockSearchNearbyPlacesUseCase;

  setUpAll(() {
    registerFallbackValue(
      SearchNearbyPlacesParams(location: const LatLng(23.1136, -82.3666)),
    );
    registerFallbackValue(
      GetPlacesByLocationParams(location: const LatLng(23.1136, -82.3666)),
    );
    registerFallbackValue(const SearchPlacesParams(query: 'test'));
    registerFallbackValue(
      const GetPlacesByCategoryParams(categoryId: 'test-category'),
    );
  });

  setUp(() {
    mockGetPlacesByCategoryUseCase = MockGetPlacesByCategoryUseCase();
    mockSearchPlacesUseCase = MockSearchPlacesUseCase();
    mockSearchPlacesByVoiceUseCase = MockSearchPlacesByVoiceUseCase();
    mockGetPlacesByLocationUseCase = MockGetPlacesByLocationUseCase();
    mockSearchNearbyPlacesUseCase = MockSearchNearbyPlacesUseCase();

    when(() => mockSearchNearbyPlacesUseCase.call(any()))
        .thenAnswer((_) async => []);
    when(() => mockGetPlacesByLocationUseCase.call(any()))
        .thenAnswer((_) async => []);
    when(() => mockSearchPlacesUseCase.call(any())).thenAnswer((_) async => []);
    when(() => mockGetPlacesByCategoryUseCase.call(any()))
        .thenAnswer((_) async => []);
    when(() => mockSearchPlacesByVoiceUseCase.call(any()))
        .thenAnswer((_) async => []);

    cubit = PlacesSearchCubit(
      getPlacesByCategoryUseCase: mockGetPlacesByCategoryUseCase,
      searchPlacesUseCase: mockSearchPlacesUseCase,
      searchPlacesByVoiceUseCase: mockSearchPlacesByVoiceUseCase,
      getPlacesByLocationUseCase: mockGetPlacesByLocationUseCase,
      searchNearbyPlacesUseCase: mockSearchNearbyPlacesUseCase,
    );
  });

  tearDown(() async {
    await cubit.close();
  });

  test('estado inicial de filtros es correcto', () {
    expect(cubit.state.minRating, 0.0);
    expect(cubit.state.showOnlyOpenNow, false);
    expect(cubit.state.sortBy, 'distance');
  });

  test('applyFilters actualiza filtros de busqueda', () async {
    cubit.initializeSearch(userLocation: const LatLng(23.1136, -82.3666));
    await Future<void>.delayed(const Duration(milliseconds: 10));

    cubit.applyFilters(
      const SearchFiltersParams(
        minRating: 4.0,
        showOnlyOpenNow: true,
        sortBy: 'rating',
      ),
    );
    await Future<void>.delayed(const Duration(milliseconds: 10));

    expect(cubit.state.minRating, 4.0);
    expect(cubit.state.showOnlyOpenNow, true);
    expect(cubit.state.sortBy, 'rating');
  });

  test('clearFilters restablece valores por defecto', () async {
    cubit.initializeSearch(userLocation: const LatLng(23.1136, -82.3666));
    await Future<void>.delayed(const Duration(milliseconds: 10));

    cubit.applyFilters(
      const SearchFiltersParams(
        minRating: 4.5,
        showOnlyOpenNow: true,
        sortBy: 'rating',
      ),
    );
    await Future<void>.delayed(const Duration(milliseconds: 10));

    cubit.clearFilters();
    await Future<void>.delayed(const Duration(milliseconds: 10));

    expect(cubit.state.minRating, 0.0);
    expect(cubit.state.showOnlyOpenNow, false);
    expect(cubit.state.sortBy, 'distance');
  });

  test('applyFilters aplica combinaciones avanzadas (amenities/precio/limit)', () async {
    cubit.initializeSearch(userLocation: const LatLng(23.1136, -82.3666));
    await Future<void>.delayed(const Duration(milliseconds: 10));

    cubit.applyFilters(
      const SearchFiltersParams(
        selectedAmenities: ['wifi', 'parking'],
        minPrice: 10,
        maxPrice: 40,
        resultsLimit: 7,
      ),
    );
    await Future<void>.delayed(const Duration(milliseconds: 10));

    expect(cubit.state.selectedAmenities, ['wifi', 'parking']);
    expect(cubit.state.minPrice, 10);
    expect(cubit.state.maxPrice, 40);
    expect(cubit.state.resultsLimit, 7);
  });

  test('applyFilters con nullables conserva valores previos', () async {
    cubit.initializeSearch(userLocation: const LatLng(23.1136, -82.3666));
    await Future<void>.delayed(const Duration(milliseconds: 10));

    cubit.applyFilters(
      const SearchFiltersParams(
        showOnlyWithReviews: true,
        showOnlyWithPhotos: true,
      ),
    );
    await Future<void>.delayed(const Duration(milliseconds: 10));
    expect(cubit.state.showOnlyWithReviews, true);
    expect(cubit.state.showOnlyWithPhotos, true);

    cubit.applyFilters(const SearchFiltersParams());
    await Future<void>.delayed(const Duration(milliseconds: 10));

    expect(cubit.state.showOnlyWithReviews, true);
    expect(cubit.state.showOnlyWithPhotos, true);
  });

  test('filtros avanzados filtran resultados de nearby', () async {
    when(() => mockSearchNearbyPlacesUseCase.call(any())).thenAnswer(
      (_) async => [
        _buildPlace(
          id: 'a',
          rating: 4.7,
          imageUrls: const ['img'],
          reviews: const [],
        ),
        _buildPlace(
          id: 'b',
          rating: 4.9,
          imageUrls: const ['img'],
          reviews: [
            Review(
              id: 'r1',
              userId: 'u1',
              userName: 'U',
              userAvatar: '',
              comment: 'Good',
              rating: 5,
              date: DateTime(2026, 1, 1),
            ),
          ],
        ),
      ],
    );

    cubit.initializeSearch(userLocation: const LatLng(23.1136, -82.3666));
    await Future<void>.delayed(const Duration(milliseconds: 10));

    cubit.applyFilters(
      const SearchFiltersParams(
        showOnlyWithReviews: true,
        showOnlyWithPhotos: true,
        showOnlyRecommended: true,
      ),
    );
    await Future<void>.delayed(const Duration(milliseconds: 10));

    expect(cubit.state.places.length, 1);
    expect(cubit.state.places.first.id, 'b');
  });

  test('initializeSearch con query usa SearchPlacesUseCase', () async {
    when(() => mockSearchPlacesUseCase.call(any())).thenAnswer(
      (_) async => [_buildPlace(id: 'q1', rating: 4.0)],
    );

    cubit.initializeSearch(initialQuery: 'pizza');
    await Future<void>.delayed(const Duration(milliseconds: 20));

    verify(() => mockSearchPlacesUseCase.call(any())).called(greaterThan(0));
    expect(cubit.state.searchType, PlaceSearchType.query);
    expect(cubit.state.places.length, 1);
  });

  test('selectCategory usa GetPlacesByCategoryUseCase', () async {
    when(() => mockGetPlacesByCategoryUseCase.call(any())).thenAnswer(
      (_) async => [_buildPlace(id: 'c1', rating: 4.0)],
    );

    cubit.selectCategory('food');
    await Future<void>.delayed(const Duration(milliseconds: 20));

    verify(() => mockGetPlacesByCategoryUseCase.call(any())).called(1);
    expect(cubit.state.searchType, PlaceSearchType.category);
    expect(cubit.state.selectedCategoryId, 'food');
    expect(cubit.state.places.first.id, 'c1');
  });

  test('searchAtLocation usa GetPlacesByLocationUseCase', () async {
    when(() => mockGetPlacesByLocationUseCase.call(any())).thenAnswer(
      (_) async => [_buildPlace(id: 'l1', rating: 3.5)],
    );

    cubit.searchAtLocation(const LatLng(23.1, -82.3));
    await Future<void>.delayed(const Duration(milliseconds: 20));

    verify(() => mockGetPlacesByLocationUseCase.call(any())).called(1);
    expect(cubit.state.searchType, PlaceSearchType.location);
    expect(cubit.state.places.first.id, 'l1');
  });

  test('initializeSearch sin query/category y con userLocation usa nearby', () async {
    when(() => mockSearchNearbyPlacesUseCase.call(any())).thenAnswer(
      (_) async => [_buildPlace(id: 'n1', rating: 4.2)],
    );

    cubit.initializeSearch(userLocation: const LatLng(23.2, -82.2));
    await Future<void>.delayed(const Duration(milliseconds: 20));

    verify(() => mockSearchNearbyPlacesUseCase.call(any())).called(1);
    expect(cubit.state.searchType, PlaceSearchType.nearby);
    expect(cubit.state.places.first.id, 'n1');
  });

  test('initializeSearch all sin ubicación deja lista vacía', () async {
    cubit.initializeSearch();
    await Future<void>.delayed(const Duration(milliseconds: 20));

    expect(cubit.state.searchType, PlaceSearchType.all);
    expect(cubit.state.places, isEmpty);
    expect(cubit.state.isLoading, isFalse);
  });

  test('selectPlace y clearSelectedPlace actualizan selectedPlace', () {
    final place = _buildPlace(id: 'p1', rating: 4.6);

    cubit.selectPlace(place);
    expect(cubit.state.selectedPlace?.id, 'p1');
    expect(cubit.state.mapCenter, const LatLng(0.0, 0.0));

    cubit.clearSelectedPlace();
    expect(cubit.state.selectedPlace, isNull);
  });

  test('updateSearchQuery con texto dispara debounce y búsqueda', () async {
    when(() => mockSearchPlacesUseCase.call(any())).thenAnswer(
      (_) async => [_buildPlace(id: 'd1', rating: 4.0)],
    );

    cubit.updateSearchQuery('helado');
    await Future<void>.delayed(const Duration(milliseconds: 600));

    verify(() => mockSearchPlacesUseCase.call(any())).called(1);
    expect(cubit.state.searchType, PlaceSearchType.query);
    expect(cubit.state.places.first.id, 'd1');
  });

  test('error en use case propaga mensaje de error en state', () async {
    when(() => mockSearchNearbyPlacesUseCase.call(any())).thenThrow(
      Exception('backend down'),
    );

    cubit.initializeSearch(userLocation: const LatLng(23.3, -82.1));
    await Future<void>.delayed(const Duration(milliseconds: 20));

    expect(cubit.state.error, isNotNull);
    expect(cubit.state.error, contains('Error cargando lugares'));
    expect(cubit.state.isLoading, isFalse);
  });

  test('initializeSearch con categoryId selecciona modo category', () async {
    when(() => mockGetPlacesByCategoryUseCase.call(any())).thenAnswer(
      (_) async => [_buildPlace(id: 'cat-init', rating: 4.4)],
    );

    cubit.initializeSearch(categoryId: 'restaurants');
    await Future<void>.delayed(const Duration(milliseconds: 20));

    expect(cubit.state.searchType, PlaceSearchType.category);
    expect(cubit.state.selectedCategoryId, 'restaurants');
    expect(cubit.state.places.first.id, 'cat-init');
  });

  test('searchByVoice usa use case de voz y actualiza resultados', () async {
    when(() => mockSearchPlacesByVoiceUseCase.call(any())).thenAnswer(
      (_) async => [_buildPlace(id: 'voice1', rating: 4.9)],
    );

    cubit.searchByVoice('pizza cerca');
    await Future<void>.delayed(const Duration(milliseconds: 20));

    verify(() => mockSearchPlacesByVoiceUseCase.call(any())).called(1);
    expect(cubit.state.searchQuery, 'pizza cerca');
    expect(cubit.state.places.first.id, 'voice1');
    expect(cubit.state.isLoading, isFalse);
  });

  test('searchByVoice maneja error y emite mensaje', () async {
    when(() => mockSearchPlacesByVoiceUseCase.call(any())).thenThrow(
      Exception('voice backend down'),
    );

    cubit.searchByVoice('pizza');
    await Future<void>.delayed(const Duration(milliseconds: 20));

    expect(cubit.state.error, isNotNull);
    expect(cubit.state.error, contains('Error en búsqueda por voz'));
    expect(cubit.state.isLoading, isFalse);
  });

  test('updateSearchQuery vacío con userLocation vuelve a nearby', () async {
    when(() => mockSearchNearbyPlacesUseCase.call(any())).thenAnswer(
      (_) async => [_buildPlace(id: 'near-reset', rating: 3.9)],
    );

    cubit.initializeSearch(userLocation: const LatLng(23.1136, -82.3666));
    await Future<void>.delayed(const Duration(milliseconds: 20));

    cubit.updateSearchQuery('');
    await Future<void>.delayed(const Duration(milliseconds: 600));

    expect(cubit.state.searchType, PlaceSearchType.nearby);
    expect(cubit.state.places.first.id, 'near-reset');
  });

  test('updateMapCenter/updateMapZoom/toggleMapStyle mutan estado', () {
    const center = LatLng(23.2, -82.4);
    cubit.updateMapCenter(center);
    expect(cubit.state.mapCenter, center);

    cubit.updateMapZoom(15);
    expect(cubit.state.mapZoom, 15);

    final initialStyle = cubit.state.isMapStyleDark;
    cubit.toggleMapStyle();
    expect(cubit.state.isMapStyleDark, !initialStyle);
  });

  test('clearSelection limpia selectedPlace', () {
    final place = _buildPlace(id: 'sel', rating: 4.0);
    cubit.selectPlace(place);
    expect(cubit.state.selectedPlace, isNotNull);

    cubit.clearSelection();
    expect(cubit.state.selectedPlace, isNull);
  });
}
