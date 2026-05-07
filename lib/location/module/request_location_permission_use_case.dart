import 'package:permission_handler/permission_handler.dart';
import 'package:turbo/app/core/no_params.dart';
import 'package:turbo/app/core/use_case.dart';

class RequestLocationPermissionUseCase
    implements UseCase<Future<bool>, NoParams> {
  RequestLocationPermissionUseCase();

  @override
  Future<bool> call(NoParams params) async {
    try {
      final status = await Permission.location.request();
      return status == PermissionStatus.granted;
    } catch (e) {
      return false;
    }
  }
}
