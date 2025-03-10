import 'package:firebase_auth/firebase_auth.dart';
import 'package:turbo/authentication/authentication_repository/models/auth_user.dart';

import 'service/authentication_service.dart';

class AuthenticationRepository {
  final AuthenticationService authService;
  AuthenticationRepository({required this.authService});

  Future<AuthUser?> signInWithEmail({
    required String email,
    required String password,
  }) async {
    final user = await authService.signInWithEmail(
      email: email,
      password: password,
    );
    return user;
  }

  Future<AuthUser?> sigInWithGoogle() async {
    return await authService.signInWithGoogle();
  }

  Future<AuthUser?> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  }) async {
    return await authService.signUpWithEmail(
      email: email,
      password: password,
      displayName: displayName,
    );
  }

  //TODO implement Change Password in Services
  Future<void> changePassword({
    required int userId,
    required String newPassword,
  }) async {
    //  await authService.(userId: userId, newPassword: newPassword);
  }
  Stream<AuthUser?> get authStateChanges => authService.authStateChanges;

  // bool isAuthenticated() => authService.isAuthenticated();
  Future<void> logOut() async => await authService.signOut();
}
