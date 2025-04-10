import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:turbo/app/core/no_params.dart';
import 'package:turbo/location/location_repository/models/location_data.dart';
import 'package:turbo/location/module/get_current_location_use_case.dart';
import 'package:turbo/location/module/request_location_permission_use_case.dart';

part 'location_state.dart';
part 'location_cubit.freezed.dart';

class LocationCubit extends Cubit<LocationState> {
  final GetCurrentLocationUseCase _getCurrentLocationUseCase;
  final RequestLocationPermissionUseCase _requestLocationPermissionUseCase;
  StreamSubscription<LocationData>? _locationSubscription;

  LocationCubit({
    required GetCurrentLocationUseCase getCurrentLocationUseCase,
    required RequestLocationPermissionUseCase requestLocationPermissionUseCase,
  }) : _getCurrentLocationUseCase = getCurrentLocationUseCase,
       _requestLocationPermissionUseCase = requestLocationPermissionUseCase,
       super(const LocationState.initial());

  Future<void> requestLocationPermission() async {
    emit(const LocationState.loading());
    try {
      final permissionGranted = await _requestLocationPermissionUseCase(
        NoParams(),
      );

      if (permissionGranted) {
        emit(const LocationState.permissionGranted());
        // Una vez que tenemos permiso, intentamos obtener la ubicación actual
        await getCurrentLocation();
      } else {
        emit(const LocationState.permissionDenied());
      }
    } catch (e) {
      emit(LocationState.error(e.toString()));
    }
  }

  Future<void> getCurrentLocation() async {
    emit(const LocationState.loading());
    try {
      final location = await _getCurrentLocationUseCase(NoParams());
      emit(LocationState.locationObtained(location: location));
    } catch (e) {
      emit(LocationState.error(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _locationSubscription?.cancel();
    return super.close();
  }
}
