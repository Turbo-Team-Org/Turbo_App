import 'package:turbo/app/core/no_params.dart';
import 'package:turbo/app/core/use_case.dart';
import '../location_repository/location_repository.dart';
import '../location_repository/models/location_data.dart';

class GetCurrentLocationUseCase
    implements UseCase<Future<LocationData>, NoParams> {
  final LocationRepository _locationRepository;

  GetCurrentLocationUseCase(this._locationRepository);

  @override
  Future<LocationData> call(NoParams params) {
    return _locationRepository.getCurrentLocation();
  }
}
