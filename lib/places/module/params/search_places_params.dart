import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'search_places_params.freezed.dart';

/// Parámetros para búsqueda por texto
@freezed
sealed class SearchPlacesParams with _$SearchPlacesParams {
  const factory SearchPlacesParams({
    required String query,
    LatLng? location,
    double? maxDistance,
    double? minRating,
    double? maxPrice,
    double? minPrice,
    String? categoryId,
  }) = _SearchPlacesParams;
}

/// Parámetros para búsqueda por ubicación
@freezed
sealed class GetPlacesByLocationParams with _$GetPlacesByLocationParams {
  const factory GetPlacesByLocationParams({
    required LatLng location,
    @Default(5000.0) double radius,
    double? minRating,
    double? maxPrice,
    double? minPrice,
    String? categoryId,
    @Default(20) int limit,
    @Default('distance') String sortBy, // distance, rating, price
  }) = _GetPlacesByLocationParams;
}

/// Parámetros para búsqueda de lugares cercanos
@freezed
sealed class SearchNearbyPlacesParams with _$SearchNearbyPlacesParams {
  const factory SearchNearbyPlacesParams({
    required LatLng location,
    @Default(5000.0) double radius,
    String? keyword,
    String? categoryId,
    double? minRating,
    @Default(20) int limit,
  }) = _SearchNearbyPlacesParams;
}

/// Parámetros para búsqueda por categoría con filtros
@freezed
sealed class GetPlacesByCategoryParams with _$GetPlacesByCategoryParams {
  const factory GetPlacesByCategoryParams({
    required String categoryId,
    LatLng? location,
    double? maxDistance,
    double? minRating,
    double? maxPrice,
    double? minPrice,
    @Default(20) int limit,
    @Default('distance') String sortBy,
  }) = _GetPlacesByCategoryParams;
}
