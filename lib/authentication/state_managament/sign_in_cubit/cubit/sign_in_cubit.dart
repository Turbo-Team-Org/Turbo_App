import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:turbo/app/core/no_params.dart';
import 'package:turbo/authentication/module/sign_in_with_email_use_case.dart';
import 'package:turbo/authentication/module/sign_with_google_use_case.dart';
import 'package:turbo/authentication/module/use_case_params_models/sign_in_use_case_params.dart';
import '../../../authentication_repository/models/auth_user.dart';

part 'sign_in_state.dart';
part 'sign_in_cubit.freezed.dart';

class SignInCubit extends Cubit<SignInState> {
  final SignInWithGoogleUseCase signInWithGoogleUseCase;
  final SignInWithEmailUseCase signInWithEmailUseCase;
  SignInCubit({
    required this.signInWithGoogleUseCase,
    required this.signInWithEmailUseCase,
  }) : super(const SignInState.initial());

  Future<void> signInWithGoogle() async {
    emit(const Loading());
    try {
      final user = await signInWithGoogleUseCase(NoParams());
      emit(Success(user!));
    } catch (error) {
      emit(Error(error: error.toString()));
    }
  }

  Future<void> signInWithEmail(String email, String password) async {
    emit(Loading());
    try {
      final user = await signInWithEmailUseCase(
        SignInParams(email: email, password: password),
      );
      emit(Success(user!));
    } catch (e) {
      emit(Error(error: e.toString()));
    }
  }
}
