import 'package:turbo/app/core/use_case.dart';
import 'package:turbo/authentication/authentication_repository/models/auth_user.dart';

import '../authentication_repository/authentication_repository.dart';
import 'use_case_params_models/sign_in_use_case_params.dart';

class SignInWithGoogleUseCase
    implements UseCase<Future<AuthUser?>, SignInParams> {
  final AuthenticationRepository authenticationRepository;
  SignInWithGoogleUseCase({required this.authenticationRepository});
  @override
  call(params) async => await authenticationRepository.sigInWithGoogle();
}
