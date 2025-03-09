part of 'sign_up_cubit.dart';

@freezed
sealed class SignUpState with _$SignUpState {
  const factory SignUpState.initial() = Initial;
  const factory SignUpState.loading() = Loading;
  const factory SignUpState.success(AuthUser user) = Success;
  const factory SignUpState.error() = Error;
}
