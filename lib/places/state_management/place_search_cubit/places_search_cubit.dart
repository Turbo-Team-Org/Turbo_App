import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:core/core.dart';
import 'package:turbo/categories/module/get_places_by_category_use_case.dart';
import 'package:turbo/places/module/search_places_use_case.dart';
import 'package:turbo/places/module/get_places_by_location_use_case.dart';
import 'package:turbo/places/module/search_nearby_places_use_case.dart';
import 'package:turbo/places/module/params/search_places_params.dart';
import 'dart:async';

part 'places_search_cubit.freezed.dart';
part 'places_search_state.dart';

class PlacesSearchCubit extends Cubit<PlacesSearchState> {
  PlacesSearchCubit({
    required GetPlacesByCategoryUseCase getPlacesByCategoryUseCase,
    required SearchPlacesUseCase searchPlacesUseCase,
    required SearchPlacesByVoiceUseCase searchPlacesByVoiceUseCase,
    required GetPlacesByLocationUseCase getPlacesByLocationUseCase,
    required SearchNearbyPlacesUseCase searchNearbyPlacesUseCase,
  }) : _getPlacesByCategoryUseCase = getPlacesByCategoryUseCase,
       _searchPlacesUseCase = searchPlacesUseCase,
       _searchPlacesByVoiceUseCase = searchPlacesByVoiceUseCase,
       _getPlacesByLocationUseCase = getPlacesByLocationUseCase,
       _searchNearbyPlacesUseCase = searchNearbyPlacesUseCase,
       super(const PlacesSearchState());

  final GetPlacesByCategoryUseCase _getPlacesByCategoryUseCase;
  final SearchPlacesUseCase _searchPlacesUseCase;
  final SearchPlacesByVoiceUseCase _searchPlacesByVoiceUseCase;
  final GetPlacesByLocationUseCase _getPlacesByLocationUseCase;
  final SearchNearbyPlacesUseCase _searchNearbyPlacesUseCase;

  Timer? _debounceTimer;

  void initializeSearch({
    String? categoryId,
    String? initialQuery,
    LatLng? userLocation,
  }) {
    PlaceSearchType searchType = PlaceSearchType.all;

    if (categoryId != null) {
      searchType = PlaceSearchType.category;
    } else if (initialQuery != null && initialQuery.isNotEmpty) {
      searchType = PlaceSearchType.query;
    } else if (userLocation != null) {
      searchType = PlaceSearchType.nearby;
    }

    emit(
      state.copyWith(
        selectedCategoryId: categoryId,
        searchQuery: initialQuery,
        userLocation: userLocation,
        searchType: searchType,
        isLoading: true,
        mapCenter: userLocation ?? state.mapCenter,
      ),
    );

    _loadPlaces();
  }

  void updateSearchQuery(String query) {
    emit(
      state.copyWith(
        searchQuery: query,
        searchType:
            query.isEmpty ? PlaceSearchType.nearby : PlaceSearchType.query,
      ),
    );
    _debounceSearch();
  }

  /// 🎤 Búsqueda por voz
  void searchByVoice(String voiceQuery) {
    emit(
      state.copyWith(
        searchQuery: voiceQuery,
        searchType: PlaceSearchType.query,
        isLoading: true,
      ),
    );
    _loadPlacesByVoice(voiceQuery);
  }

  void selectCategory(String categoryId) {
    emit(
      state.copyWith(
        selectedCategoryId: categoryId,
        searchQuery: '',
        searchType: PlaceSearchType.category,
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

  /// Limpia la selección del lugar
  void clearSelectedPlace() {
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

  /// Actualiza filtros básicos
  void updateFilters({
    double? maxDistance,
    double? minRating,
    double? maxPrice,
    double? minPrice,
    String? sortBy,
  }) {
    emit(
      state.copyWith(
        maxDistance: maxDistance ?? state.maxDistance,
        minRating: minRating ?? state.minRating,
        maxPrice: maxPrice,
        minPrice: minPrice,
        sortBy: sortBy ?? state.sortBy,
        isLoading: true,
      ),
    );
    _loadPlaces();
  }

  /// Actualiza filtros avanzados tipo Yelp
  void updateAdvancedFilters({
    bool? showOnlyOpenNow,
    List<String>? selectedAmenities,
    bool? showOnlyWithReviews,
    bool? showOnlyWithPhotos,
    bool? showOnlyRecommended,
    int? resultsLimit,
  }) {
    emit(
      state.copyWith(
        showOnlyOpenNow: showOnlyOpenNow ?? state.showOnlyOpenNow,
        selectedAmenities: selectedAmenities ?? state.selectedAmenities,
        showOnlyWithReviews: showOnlyWithReviews ?? state.showOnlyWithReviews,
        showOnlyWithPhotos: showOnlyWithPhotos ?? state.showOnlyWithPhotos,
        showOnlyRecommended: showOnlyRecommended ?? state.showOnlyRecommended,
        resultsLimit: resultsLimit ?? state.resultsLimit,
        isLoading: true,
      ),
    );
    _loadPlaces();
  }

  /// Busca lugares cercanos basándose en la ubicación actual
  void searchNearby(LatLng location, {double? radius}) {
    emit(
      state.copyWith(
        userLocation: location,
        mapCenter: location,
        maxDistance: radius ?? state.maxDistance,
        searchType: PlaceSearchType.nearby,
        isLoading: true,
      ),
    );
    _loadPlaces();
  }

  /// Busca en una ubicación específica
  void searchAtLocation(LatLng location) {
    emit(
      state.copyWith(
        mapCenter: location,
        searchType: PlaceSearchType.location,
        isLoading: true,
      ),
    );
    _loadPlaces();
  }

  /// Limpia todos los filtros
  void clearFilters() {
    emit(
      state.copyWith(
        selectedCategoryId: null,
        searchQuery: '',
        minRating: 0.0,
        maxPrice: null,
        minPrice: null,
        maxDistance: 5000.0,
        sortBy: 'distance',
        showOnlyOpenNow: false,
        selectedAmenities: [],
        showOnlyWithReviews: false,
        showOnlyWithPhotos: false,
        showOnlyRecommended: false,
        searchType: PlaceSearchType.nearby,
        isLoading: true,
      ),
    );
    _loadPlaces();
  }

  void _loadPlaces() async {
    try {
      emit(state.copyWith(isLoading: true, error: null));

      List<Place> places;

      // Determinar qué tipo de búsqueda realizar
      switch (state.searchType) {
        case PlaceSearchType.query:
          if (state.searchQuery?.isNotEmpty ?? false) {
            places = await _searchPlacesUseCase(
              SearchPlacesParams(
                query: state.searchQuery!,
                location: state.userLocation,
                maxDistance: state.maxDistance,
                minRating: state.minRating,
                maxPrice: state.maxPrice,
                minPrice: state.minPrice,
                categoryId: state.selectedCategoryId,
              ),
            );
          } else {
            places = [];
          }
          break;

        case PlaceSearchType.category:
          if (state.selectedCategoryId != null) {
            places = await _getPlacesByCategoryUseCase(
              GetPlacesByCategoryParams(
                categoryId: state.selectedCategoryId!,
                location: state.userLocation,
                maxDistance: state.maxDistance,
                minRating: state.minRating,
                maxPrice: state.maxPrice,
                minPrice: state.minPrice,
                limit: state.resultsLimit,
                sortBy: state.sortBy,
              ),
            );
          } else {
            places = [];
          }
          break;

        case PlaceSearchType.nearby:
          if (state.userLocation != null) {
            places = await _searchNearbyPlacesUseCase(
              SearchNearbyPlacesParams(
                location: state.userLocation!,
                radius: state.maxDistance,
                categoryId: state.selectedCategoryId,
                minRating: state.minRating,
                limit: state.resultsLimit,
              ),
            );
          } else {
            places = [];
          }
          break;

        case PlaceSearchType.location:
          if (state.mapCenter != null) {
            places = await _getPlacesByLocationUseCase(
              GetPlacesByLocationParams(
                location: state.mapCenter!,
                radius: state.maxDistance,
                categoryId: state.selectedCategoryId,
                minRating: state.minRating,
                maxPrice: state.maxPrice,
                minPrice: state.minPrice,
                limit: state.resultsLimit,
                sortBy: state.sortBy,
              ),
            );
          } else {
            places = [];
          }
          break;

        case PlaceSearchType.all:
        default:
          // Fallback a búsqueda general si hay ubicación
          if (state.userLocation != null) {
            places = await _getPlacesByLocationUseCase(
              GetPlacesByLocationParams(
                location: state.userLocation!,
                radius: state.maxDistance,
                minRating: state.minRating,
                maxPrice: state.maxPrice,
                minPrice: state.minPrice,
                limit: state.resultsLimit,
                sortBy: state.sortBy,
              ),
            );
          } else {
            places = [];
          }
          break;
      }

      // Aplicar filtros avanzados
      places = _applyAdvancedFilters(places);

      emit(
        state.copyWith(
          places: places,
          isLoading: false,
          mapCenter:
              state.mapCenter ??
              (places.isNotEmpty &&
                      places.first.latitude != null &&
                      places.first.longitude != null
                  ? LatLng(places.first.latitude!, places.first.longitude!)
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

  /// 🎤 Carga lugares por búsqueda de voz
  void _loadPlacesByVoice(String voiceQuery) async {
    try {
      emit(state.copyWith(isLoading: true, error: null));

      final places = await _searchPlacesByVoiceUseCase(
        SearchPlacesParams(
          query: voiceQuery,
          location: state.userLocation,
          maxDistance: state.maxDistance,
          minRating: state.minRating,
          maxPrice: state.maxPrice,
          minPrice: state.minPrice,
          categoryId: state.selectedCategoryId,
        ),
      );

      // Aplicar filtros avanzados
      final filteredPlaces = _applyAdvancedFilters(places);

      emit(
        state.copyWith(
          places: filteredPlaces,
          isLoading: false,
          mapCenter:
              state.mapCenter ??
              (filteredPlaces.isNotEmpty &&
                      filteredPlaces.first.latitude != null &&
                      filteredPlaces.first.longitude != null
                  ? LatLng(
                    filteredPlaces.first.latitude!,
                    filteredPlaces.first.longitude!,
                  )
                  : const LatLng(23.1136, -82.3666)), // La Habana por defecto
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          error: 'Error en búsqueda por voz: ${e.toString()}',
        ),
      );
    }
  }

  /// Aplica filtros avanzados a la lista de lugares
  List<Place> _applyAdvancedFilters(List<Place> places) {
    List<Place> filtered = places;

    // Filtro: solo con reseñas
    if (state.showOnlyWithReviews) {
      filtered =
          filtered
              .where((place) => place.reviews?.isNotEmpty ?? false)
              .toList();
    }

    // Filtro: solo con fotos
    if (state.showOnlyWithPhotos) {
      filtered =
          filtered
              .where((place) => place.imageUrls?.isNotEmpty ?? false)
              .toList();
    }

    // Filtro: solo recomendados (rating >= 4.0)
    if (state.showOnlyRecommended) {
      filtered = filtered.where((place) => (place.rating ?? 0) >= 4.0).toList();
    }

    // TODO: Implementar filtro de lugares abiertos cuando tengamos horarios
    // if (state.showOnlyOpenNow) {
    //   filtered = filtered.where((place) => place.isOpenNow).toList();
    // }

    return filtered;
  }

  void _debounceSearch() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      if (state.searchQuery?.isNotEmpty ?? false) {
        _loadPlaces();
      } else if (state.userLocation != null) {
        // Si no hay query, mostrar lugares cercanos
        emit(state.copyWith(searchType: PlaceSearchType.nearby));
        _loadPlaces();
      }
    });
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }
}
