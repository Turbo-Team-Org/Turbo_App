part of 'profile_cubit.dart';

@freezed
sealed class ProfileState with _$ProfileState {
  const factory ProfileState.initial() = ProfileInitial;
  const factory ProfileState.loading() = ProfileLoading;
  const factory ProfileState.loaded({required UserProfile profile}) =
      ProfileLoaded;
  const factory ProfileState.updating() = ProfileUpdating;
  const factory ProfileState.updateSuccess({required UserProfile profile}) =
      ProfileUpdateSuccess;
  const factory ProfileState.error({required String message}) = ProfileError;
}
