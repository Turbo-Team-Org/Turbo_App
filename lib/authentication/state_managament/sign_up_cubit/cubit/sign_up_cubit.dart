import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:turbo/authentication/authentication_repository/models/auth_user.dart';
import 'package:turbo/authentication/module/sign_up_with_email_use_case.dart';
import 'package:turbo/authentication/module/use_case_params_models/sign_in_use_case_params.dart';

part 'sign_up_state.dart';
part 'sign_up_cubit.freezed.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpWithEmailUseCase signUpWithEmailUseCase;

  SignUpCubit({required this.signUpWithEmailUseCase})
    : super(SignUpState.initial());
  Future<AuthUser?> signUpWithEmail(
    String email,
    String password,
    String? displayName,
  ) async {
    emit(Loading());
    try {
      final user = await signUpWithEmailUseCase(
        SignInParams(
          email: email,
          password: password,
          displayName: displayName,
        ),
      );
      if (user != null) {
        emit(Success(user));
        return user;
      } else {
        return null;
      }
    } catch (e) {
      emit(Error(e.toString()));
      return null;
    }
  }
}
