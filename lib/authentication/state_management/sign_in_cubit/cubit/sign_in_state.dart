part of 'sign_in_cubit.dart';

@freezed
sealed class SignInState with _$SignInState {
  const factory SignInState.initial() = Initial;
  const factory SignInState.success(AuthUser user) = Success;
  const factory SignInState.error({required String error}) = Error;
  const factory SignInState.loading() = Loading;
}
