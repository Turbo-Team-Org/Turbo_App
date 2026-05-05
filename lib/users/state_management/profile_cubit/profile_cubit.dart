import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/user_profile.dart';
import '../../module/get_user_profile_use_case.dart';
import '../../module/update_user_profile_use_case.dart';

part 'profile_state.dart';
part 'profile_cubit.freezed.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({
    required GetUserProfileUseCase getUserProfileUseCase,
    required UpdateUserProfileUseCase updateUserProfileUseCase,
  })  : _getUserProfileUseCase = getUserProfileUseCase,
        _updateUserProfileUseCase = updateUserProfileUseCase,
        super(const ProfileState.initial());

  final GetUserProfileUseCase _getUserProfileUseCase;
  final UpdateUserProfileUseCase _updateUserProfileUseCase;

  Future<void> loadProfile() async {
    emit(const ProfileState.loading());
    try {
      final profile = await _getUserProfileUseCase();
      if (profile == null) {
        emit(const ProfileState.error(message: 'No authenticated user'));
        return;
      }
      emit(ProfileState.loaded(profile: profile));
    } catch (e) {
      emit(ProfileState.error(message: e.toString()));
    }
  }

  Future<void> updateProfile(UpdateUserProfileParams params) async {
    emit(const ProfileState.updating());
    try {
      final profile = await _updateUserProfileUseCase(params);
      emit(ProfileState.updateSuccess(profile: profile));
    } catch (e) {
      emit(ProfileState.error(message: e.toString()));
    }
  }
}
