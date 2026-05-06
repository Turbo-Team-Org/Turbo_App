part of 'location_cubit.dart';

@freezed
sealed class LocationState with _$LocationState {
  const factory LocationState.initial() = LocationInitial;
  const factory LocationState.loading() = LocationLoading;
  const factory LocationState.permissionDenied() = LocationPermissionDenied;
  const factory LocationState.permissionGranted() = LocationPermissionGranted;
  const factory LocationState.locationObtained({
    required LocationData location,
  }) = LocationObtained;
  const factory LocationState.error(String message) = LocationError;
}
