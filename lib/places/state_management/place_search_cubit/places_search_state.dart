part of 'places_search_cubit.dart';

@freezed
sealed class PlacesSearchState with _$PlacesSearchState {
  const factory PlacesSearchState({
    @Default([]) List<Place> places,
    @Default(false) bool isLoading,
    String? error,
    String? searchQuery,
    String? selectedCategoryId,
    Place? selectedPlace,
    LatLng? userLocation,
    LatLng? mapCenter,
    @Default(14.0) double mapZoom,
    @Default(false) bool isMapStyleDark,
    @Default(5000.0) double maxDistance, // metros
    @Default(0.0) double minRating,
    double? maxPrice,
    double? minPrice,
    @Default('distance') String sortBy, // distance, rating, price, newest
    @Default(false) bool showOnlyOpenNow,
    @Default([]) List<String> selectedAmenities,
    @Default(PlaceSearchType.all) PlaceSearchType searchType,
    @Default(20) int resultsLimit,
    // Filtros adicionales tipo Yelp
    @Default(false) bool showOnlyWithReviews,
    @Default(false) bool showOnlyWithPhotos,
    @Default(false) bool showOnlyRecommended,
  }) = _PlacesSearchState;
}

/// Tipos de búsqueda disponibles
enum PlaceSearchType {
  all, // Todos los lugares
  category, // Por categoría específica
  query, // Por texto de búsqueda
  nearby, // Lugares cercanos
  location, // Por ubicación específica
}
