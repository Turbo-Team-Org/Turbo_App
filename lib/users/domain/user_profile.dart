import 'package:core/core.dart';

/// Datos de perfil para la capa de presentación (App).
/// Construido desde [AuthUser] de Core más métricas opcionales.
class UserProfile {
  const UserProfile({
    required this.uid,
    required this.email,
    this.displayName,
    this.photoUrl,
    this.favoritesCount = 0,
    this.reservationsCount = 0,
    this.reviewsCount = 0,
  });

  factory UserProfile.fromAuthUser(
    AuthUser user, {
    int reservationsCount = 0,
    int reviewsCount = 0,
  }) {
    return UserProfile(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoUrl: user.photoUrl,
      favoritesCount: user.favorites.length,
      reservationsCount: reservationsCount,
      reviewsCount: reviewsCount,
    );
  }

  final String uid;
  final String email;
  final String? displayName;
  final String? photoUrl;
  final int favoritesCount;
  final int reservationsCount;
  final int reviewsCount;

  UserProfile copyWith({
    String? uid,
    String? email,
    String? displayName,
    String? photoUrl,
    int? favoritesCount,
    int? reservationsCount,
    int? reviewsCount,
  }) {
    return UserProfile(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      favoritesCount: favoritesCount ?? this.favoritesCount,
      reservationsCount: reservationsCount ?? this.reservationsCount,
      reviewsCount: reviewsCount ?? this.reviewsCount,
    );
  }
}
