import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:turbo/app/core/no_params.dart';
import 'package:turbo/authentication/module/sign_out_use_case.dart';

part 'sign_out_state.dart';
part 'sign_out_cubit.freezed.dart';

class SignOutCubit extends Cubit<SignOutState> {
  final SignOutUseCase signOutUseCase;
  SignOutCubit({required this.signOutUseCase}) : super(SignOutState.initial());

  Future<void> signOut() async {
    emit(Loading());
    try {
      await signOutUseCase(NoParams());
      emit(Success());
    } catch (e) {
      emit(Error());
    }
  }
}
