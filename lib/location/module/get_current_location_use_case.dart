import 'package:core/core.dart';
import 'package:turbo/app/core/no_params.dart';
import 'package:turbo/app/core/use_case.dart';

class GetCurrentLocationUseCase
    implements UseCase<Future<LocationData>, NoParams> {
  final LocationRepository _locationRepository;

  GetCurrentLocationUseCase(this._locationRepository);

  @override
  Future<LocationData> call(NoParams params) {
    return _locationRepository.getCurrentLocation();
  }
}
