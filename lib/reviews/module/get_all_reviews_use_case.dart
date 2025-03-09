import 'package:turbo/app/core/use_case.dart';

import '../../app/core/no_params.dart';
import '../review_repository/models/review.dart';
import '../review_repository/review_repository.dart';

class GetAllReviewsUseCase implements UseCase<Future<List<Review>>, NoParams> {
  final ReviewRepository reviewRepository;

  GetAllReviewsUseCase({required this.reviewRepository});

  @override
  Future<List<Review>> call(NoParams params) async =>
      await reviewRepository.getReviews();
}
