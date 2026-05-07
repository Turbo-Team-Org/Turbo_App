import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mocktail/mocktail.dart';
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
}
