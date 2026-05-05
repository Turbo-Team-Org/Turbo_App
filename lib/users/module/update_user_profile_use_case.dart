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
    final auth = await _authenticationRepository.updateUserProfile(
      displayName: params.displayName,
      photoUrl: params.photoUrl,
    );
    return UserProfile.fromAuthUser(auth);
  }
}
