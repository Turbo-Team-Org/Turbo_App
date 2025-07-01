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
    // PriceRange? priceRange, // Comentado hasta que se defina en el core
  }) = _PlacesSearchState;
}
