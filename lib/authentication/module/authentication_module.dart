import 'package:turbo/app/core/no_params.dart';
import 'package:turbo/app/core/use_case.dart';
import 'package:turbo/authentication/authentication_repository/authentication_repository.dart';
import 'package:turbo/authentication/authentication_repository/models/auth_user.dart';

class AuthenticationModule implements UseCase<Stream<AuthUser?>, NoParams> {
  AuthenticationRepository authenticationRepository;
  AuthenticationModule({required this.authenticationRepository});
  @override
  Stream<AuthUser?> call(NoParams params) =>
      authenticationRepository.authStateChanges;
}
