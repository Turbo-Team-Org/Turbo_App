part of 'place_cubit.dart';

@freezed
sealed class PlaceState with _$PlaceState {
  const factory PlaceState.initial() = PlacesInitial;
  const factory PlaceState.loading() = PlacesLoading;
  const factory PlaceState.loaded({required List<Place> places}) = PlacesLoaded;
  const factory PlaceState.error(String error) = PlacesError;
}
