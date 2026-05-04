import 'package:core/core.dart';
import 'package:turbo/app/core/use_case.dart';

class UpdateReviewUseCase implements UseCase<Future<void>, Review> {
  final ReviewRepository reviewRepository;

  UpdateReviewUseCase({required this.reviewRepository});

  @override
  Future<void> call(Review review) async =>
      await reviewRepository.updateReview(review);
}
