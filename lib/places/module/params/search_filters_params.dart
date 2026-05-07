import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_filters_params.freezed.dart';

@freezed
sealed class SearchFiltersParams with _$SearchFiltersParams {
  const factory SearchFiltersParams({
    @Default(0.0) double minRating,
    @Default(5000.0) double maxDistance,
    @Default('distance') String sortBy,
    @Default(false) bool showOnlyOpenNow,
    @Default(<String>[]) List<String> selectedAmenities,
    double? maxPrice,
    double? minPrice,
    bool? showOnlyWithReviews,
    bool? showOnlyWithPhotos,
    bool? showOnlyRecommended,
    int? resultsLimit,
  }) = _SearchFiltersParams;
}
