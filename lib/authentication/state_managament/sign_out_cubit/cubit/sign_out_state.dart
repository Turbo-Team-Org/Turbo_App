part of 'sign_out_cubit.dart';

@freezed
sealed class SignOutState with _$SignOutState {
  const factory SignOutState.initial() = Initial;
  const factory SignOutState.loading() = Loading;
  const factory SignOutState.success() = Success;
  const factory SignOutState.error() = Error;
}
