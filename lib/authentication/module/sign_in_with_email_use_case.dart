import 'package:core/core.dart';
import 'package:turbo/app/core/use_case.dart';
import 'package:turbo/authentication/module/use_case_params_models/sign_in_use_case_params.dart';

class SignInWithEmailUseCase
    implements UseCase<Future<AuthUser?>, SignInParams> {
  final AuthenticationRepository authenticationRepository;
  SignInWithEmailUseCase({required this.authenticationRepository});
  @override
  call(params) async => await authenticationRepository.signInWithEmail(
    email: params.email,
    password: params.password,
  );
}
