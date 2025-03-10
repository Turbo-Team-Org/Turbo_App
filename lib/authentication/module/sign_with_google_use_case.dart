import 'package:turbo/app/core/no_params.dart';
import 'package:turbo/app/core/use_case.dart';
import 'package:turbo/authentication/authentication_repository/models/auth_user.dart';

import '../authentication_repository/authentication_repository.dart';

class SignInWithGoogleUseCase implements UseCase<Future<AuthUser?>, NoParams> {
  final AuthenticationRepository authenticationRepository;
  SignInWithGoogleUseCase({required this.authenticationRepository});
  @override
  call(params) async => await authenticationRepository.sigInWithGoogle();
}
