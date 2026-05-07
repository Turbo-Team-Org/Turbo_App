import 'package:core/core.dart';

class GetUserReviewsUseCase {
  const GetUserReviewsUseCase({
    required ReviewRepository reviewRepository,
  }) : _reviewRepository = reviewRepository;

  final ReviewRepository _reviewRepository;

  Future<List<Review>> call(String userId) async {
    final paged = await _reviewRepository.getReviewsByUserId(
      userId,
      page: 1,
      limit: 100,
    );
    return paged.items;
  }
}
