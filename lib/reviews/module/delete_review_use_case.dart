import 'package:core/core.dart';
import 'package:turbo/app/core/use_case.dart';

import 'review_models_params/delete_review_params.dart';

class DeleteReviewUseCase
    implements UseCase<Future<void>, DeleteReviewParams> {
  final ReviewRepository reviewRepository;

  DeleteReviewUseCase({required this.reviewRepository});

  @override
  Future<void> call(DeleteReviewParams params) async =>
      await reviewRepository.deleteReview(params.reviewId);
}
