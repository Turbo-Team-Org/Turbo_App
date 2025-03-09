import 'package:turbo/app/core/use_case.dart';
import 'package:turbo/reviews/review_repository/review_repository.dart';
import 'package:turbo/reviews/module/review_models_params/add_review_params.dart';

class AddReviewUseCase implements UseCase<Future<void>, AddReviewParams> {
  final ReviewRepository reviewRepository;

  AddReviewUseCase({required this.reviewRepository});

  @override
  Future<void> call(AddReviewParams params) async =>
      await reviewRepository.addReview(params.review, params.placeId);
}
