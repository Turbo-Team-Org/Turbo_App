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
      ) as AuthUser;
      return UserProfile.fromAuthUser(auth);
    } on NoSuchMethodError {
      // Backward compatibility for core refs that still expose only updateDisplayName().
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
}
