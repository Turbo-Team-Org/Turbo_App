import 'package:core/core.dart';
import 'package:turbo/app/core/no_params.dart';
import 'package:turbo/app/core/use_case.dart';

class AuthenticationModule implements UseCase<Stream<AuthUser?>, NoParams> {
  AuthenticationRepository authenticationRepository;
  AuthenticationModule({required this.authenticationRepository});
  @override
  Stream<AuthUser?> call(NoParams params) =>
      authenticationRepository.authStateChanges;
}
