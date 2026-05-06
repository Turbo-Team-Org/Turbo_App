import 'package:core/core.dart';

import '../domain/user_profile.dart';

class GetUserProfileUseCase {
  GetUserProfileUseCase({
    required AuthenticationRepository authenticationRepository,
    required ReservationRepository reservationRepository,
    required ReviewRepository reviewRepository,
  })  : _authenticationRepository = authenticationRepository,
        _reservationRepository = reservationRepository,
        _reviewRepository = reviewRepository;

  final AuthenticationRepository _authenticationRepository;
  final ReservationRepository _reservationRepository;
  final ReviewRepository _reviewRepository;

  Future<UserProfile?> call() async {
    final dynamic repository = _authenticationRepository;
    AuthUser? auth;
    try {
      auth = await repository.getCurrentProfile() as AuthUser?;
    } on NoSuchMethodError {
      auth = await _authenticationRepository.getCurrentUser();
    }
    if (auth == null) {
      return null;
    }

    var reservationsCount = 0;
    var reviewsCount = 0;

    try {
      final reservations = await _reservationRepository.getUserReservations(auth.uid);
      reservationsCount = reservations.length;
    } catch (_) {
      reservationsCount = 0;
    }

    try {
      final pagedReviews = await _reviewRepository.getReviewsByUserId(
        auth.uid,
        page: 1,
        limit: 1,
      );
      reviewsCount = pagedReviews.totalCount;
    } catch (_) {
      reviewsCount = 0;
    }

    return UserProfile.fromAuthUser(
      auth,
      reservationsCount: reservationsCount,
      reviewsCount: reviewsCount,
    );
  }
}
