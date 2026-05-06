import 'package:core/core.dart';
import 'package:turbo/app/core/use_case.dart';
import 'package:turbo/authentication/module/use_case_params_models/sign_in_use_case_params.dart';

class SignUpWithEmailUseCase
    implements UseCase<Future<AuthUser?>, SignInParams> {
  AuthenticationRepository authenticationRepository;
  SignUpWithEmailUseCase({required this.authenticationRepository});

  @override
  Future<AuthUser?> call(params) async =>
      await authenticationRepository.signUpWithEmail(
        email: params.email,
        password: params.password,
        displayName: params.displayName,
      );
}
