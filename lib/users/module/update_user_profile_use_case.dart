import 'package:core/core.dart';

import '../domain/user_profile.dart';

class UpdateUserProfileParams {
  const UpdateUserProfileParams({
    this.displayName,
    this.photoUrl,
  });

  final String? displayName;
  final String? photoUrl;
}

class UpdateUserProfileUseCase {
  UpdateUserProfileUseCase({
    required AuthenticationRepository authenticationRepository,
  }) : _authenticationRepository = authenticationRepository;

  final AuthenticationRepository _authenticationRepository;

  Future<UserProfile> call(UpdateUserProfileParams params) async {
    final dynamic repository = _authenticationRepository;
    try {
      final auth = await repository.updateUserProfile(
        displayName: params.displayName,
        photoUrl: params.photoUrl,
      );
      if (auth is! AuthUser) {
        throw StateError('Invalid user response when updating profile');
      }
      return UserProfile.fromAuthUser(auth);
    } on NoSuchMethodError {
      return _fallbackUpdate(params);
    } on TypeError {
      return _fallbackUpdate(params);
    } on StateError {
      return _fallbackUpdate(params);
    }
  }

  Future<UserProfile> _fallbackUpdate(UpdateUserProfileParams params) async {
    final displayName = params.displayName?.trim();
    if (displayName != null && displayName.isNotEmpty) {
      await _authenticationRepository.updateDisplayName(displayName);
    }
    final auth = await _authenticationRepository.getCurrentUser();
    if (auth == null) {
      throw Exception('No authenticated user');
    }
    return UserProfile.fromAuthUser(auth);
  }
}
