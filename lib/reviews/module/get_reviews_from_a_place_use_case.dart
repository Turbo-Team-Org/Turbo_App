import 'package:turbo/app/core/use_case.dart';
import 'package:turbo/reviews/review_repository/review_repository.dart';

import '../review_repository/models/review.dart';

class GetReviewsFromAPlaceUseCase
    implements UseCase<Future<List<Review>>, String> {
  final ReviewRepository reviewRepository;

  GetReviewsFromAPlaceUseCase({required this.reviewRepository});

  @override
  Future<List<Review>> call(String placeId) async =>
      await reviewRepository.getReviewsFromAPlace(placeId);
}
