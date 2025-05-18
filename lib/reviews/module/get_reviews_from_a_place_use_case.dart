import 'package:core/core.dart';
import 'package:turbo/app/core/use_case.dart';

class GetReviewsFromAPlaceUseCase
    implements UseCase<Future<List<Review>>, String> {
  final ReviewRepository reviewRepository;

  GetReviewsFromAPlaceUseCase({required this.reviewRepository});

  @override
  Future<List<Review>> call(String placeId) async =>
      await reviewRepository.getReviewsFromAPlace(placeId);
}
