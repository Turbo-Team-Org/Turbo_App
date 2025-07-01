import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:core/core.dart';

part 'places_search_cubit.freezed.dart';
part 'places_search_state.dart';

class PlacesSearchCubit extends Cubit<PlacesSearchState> {
  PlacesSearchCubit() : super(const PlacesSearchState());

  // Use cases (se implementarán cuando el core esté listo)
  // final GetPlacesByLocationUseCase _getPlacesByLocationUseCase;
  // final GetPlacesByCategoryUseCase _getPlacesByCategoryUseCase;
  // final SearchPlacesUseCase _searchPlacesUseCase;

  void initializeSearch({
    String? categoryId,
    String? initialQuery,
    LatLng? userLocation,
  }) {
    emit(
      state.copyWith(
        selectedCategoryId: categoryId,
        searchQuery: initialQuery,
        userLocation: userLocation,
        isLoading: true,
      ),
    );

    _loadPlaces();
  }

  void updateSearchQuery(String query) {
    emit(state.copyWith(searchQuery: query));
    _debounceSearch();
  }

  void selectCategory(String categoryId) {
    emit(
      state.copyWith(
        selectedCategoryId: categoryId,
        searchQuery: '',
        isLoading: true,
      ),
    );
    _loadPlaces();
  }

  void selectPlace(Place place) {
    emit(
      state.copyWith(
        selectedPlace: place,
        mapCenter: LatLng(place.latitude ?? 0, place.longitude ?? 0),
      ),
    );
  }

  void clearSelection() {
    emit(state.copyWith(selectedPlace: null));
  }

  void updateMapCenter(LatLng center) {
    emit(state.copyWith(mapCenter: center));
  }

  void updateMapZoom(double zoom) {
    emit(state.copyWith(mapZoom: zoom));
  }

  void toggleMapStyle() {
    emit(state.copyWith(isMapStyleDark: !state.isMapStyleDark));
  }

  void updateFilters({double? maxDistance, double? minRating}) {
    emit(
      state.copyWith(
        maxDistance: maxDistance ?? state.maxDistance,
        minRating: minRating ?? state.minRating,
        isLoading: true,
      ),
    );
    _loadPlaces();
  }

  void _loadPlaces() async {
    try {
      emit(state.copyWith(isLoading: true, error: null));

      // TODO: Implementar cuando el core esté listo
      // List<Place> places;
      //
      // if (state.searchQuery?.isNotEmpty ?? false) {
      //   places = await _searchPlacesUseCase(SearchPlacesParams(
      //     query: state.searchQuery!,
      //     location: state.userLocation,
      //     maxDistance: state.maxDistance,
      //   ));
      // } else if (state.selectedCategoryId != null) {
      //   places = await _getPlacesByCategoryUseCase(GetPlacesByCategoryParams(
      //     categoryId: state.selectedCategoryId!,
      //     location: state.userLocation,
      //     maxDistance: state.maxDistance,
      //   ));
      // } else {
      //   places = await _getPlacesByLocationUseCase(GetPlacesByLocationParams(
      //     location: state.userLocation!,
      //     radius: state.maxDistance,
      //   ));
      // }

      // Mock data por ahora
      await Future.delayed(const Duration(milliseconds: 800));
      final List<Place> mockPlaces = _getMockPlaces();

      emit(
        state.copyWith(
          places: mockPlaces,
          isLoading: false,
          mapCenter:
              state.mapCenter ??
              (mockPlaces.isNotEmpty
                  ? LatLng(
                    mockPlaces.first.latitude ?? 23.1136,
                    mockPlaces.first.longitude ?? -82.3666,
                  )
                  : const LatLng(23.1136, -82.3666)), // La Habana por defecto
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          error: 'Error cargando lugares: ${e.toString()}',
        ),
      );
    }
  }

  void _debounceSearch() {
    // TODO: Implementar debounce para búsqueda
    Future.delayed(const Duration(milliseconds: 500), () {
      if (state.searchQuery?.isNotEmpty ?? false) {
        _loadPlaces();
      }
    });
  }

  // Mock data para testing
  List<Place> _getMockPlaces() {
    return [
      Place(
        id: '1',
        name: 'Osteria Francescana',
        description: 'Restaurante italiano auténtico',
        address: 'Calle 23, Vedado, La Habana',
        latitude: 23.1350,
        longitude: -82.3829,
        rating: 4.8,
        categoryId: 'restaurants',
        imageUrls: [], // Sin imágenes por ahora para evitar errores de red
        averagePrice: 25.0,
        reviews: [],
        // phoneNumber: '+53 7 123 4567',
      ),
      Place(
        id: '2',
        name: 'Trattoria Bella Notte',
        description: 'Pizza y pasta casera',
        address: 'Avenida Primera, Miramar',
        latitude: 23.1167,
        longitude: -82.4333,
        rating: 4.7,
        categoryId: 'restaurants',
        imageUrls: [],
        averagePrice: 20.0,
        reviews: [],
        // phoneNumber: '+53 7 234 5678',
      ),
      Place(
        id: '3',
        name: 'Osteria Luna Rossa',
        description: 'Mariscos frescos del día',
        address: 'Malecón, Habana Vieja',
        latitude: 23.1419,
        longitude: -82.3614,
        rating: 4.6,
        categoryId: 'restaurants',
        imageUrls: [],
        averagePrice: 30.0,
        reviews: [],
        // phoneNumber: '+53 7 345 6789',
      ),
      Place(
        id: '4',
        name: 'Bar El Floridita',
        description: 'Bar histórico de La Habana',
        address: 'Obispo 557, Habana Vieja',
        latitude: 23.1395,
        longitude: -82.3520,
        rating: 4.5,
        categoryId: 'bars',
        imageUrls: [],
        averagePrice: 15.0,
        reviews: [],
      ),
      Place(
        id: '5',
        name: 'Café Tornillo',
        description: 'Café cubano tradicional',
        address: 'San Lázaro, Centro Habana',
        latitude: 23.1380,
        longitude: -82.3650,
        rating: 4.3,
        categoryId: 'cafes',
        imageUrls: [],
        averagePrice: 8.0,
        reviews: [],
      ),
    ];
  }
}
