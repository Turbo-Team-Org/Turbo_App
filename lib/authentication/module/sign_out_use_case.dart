import 'package:core/core.dart';
import 'package:turbo/app/core/no_params.dart';
import 'package:turbo/app/core/use_case.dart';

class SignOutUseCase implements UseCase<Future<void>, NoParams> {
  AuthenticationRepository authenticationRepository;
  SignOutUseCase({required this.authenticationRepository});

  @override
  Future<void> call(NoParams params) async => authenticationRepository.logOut();
}
