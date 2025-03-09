import '../../review_repository/models/review.dart';

class AddReviewParams {
  final Review review;
  final String placeId;

  AddReviewParams({required this.review, required this.placeId});
}
