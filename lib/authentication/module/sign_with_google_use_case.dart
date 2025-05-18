import 'package:core/core.dart';
import 'package:turbo/app/core/no_params.dart';
import 'package:turbo/app/core/use_case.dart';

class SignInWithGoogleUseCase implements UseCase<Future<AuthUser?>, NoParams> {
  final AuthenticationRepository authenticationRepository;
  SignInWithGoogleUseCase({required this.authenticationRepository});
  @override
  call(params) async => await authenticationRepository.sigInWithGoogle();
}
