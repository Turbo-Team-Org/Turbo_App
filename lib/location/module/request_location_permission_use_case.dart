import 'package:turbo/app/core/no_params.dart';
import 'package:turbo/app/core/use_case.dart';
import '../location_repository/location_repository.dart';

class RequestLocationPermissionUseCase
    implements UseCase<Future<bool>, NoParams> {
  final LocationRepository _locationRepository;

  RequestLocationPermissionUseCase(this._locationRepository);

  @override
  Future<bool> call(NoParams params) {
    return _locationRepository.requestLocationPermission();
  }
}
