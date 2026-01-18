part of 'auth_cubit_cubit.dart';

@freezed
sealed class AuthCubitState with _$AuthCubitState {
  const factory AuthCubitState.initial() = Initial;
  const factory AuthCubitState.authenticated(AuthUser user) = Authenticated;
  const factory AuthCubitState.unauthenticated() = Unauthenticated;
}
