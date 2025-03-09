import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../app/core/no_params.dart';
import '../../module/add_review_use_case.dart';
import '../../module/get_all_reviews_use_case.dart';
import '../../module/get_reviews_from_a_place_use_case.dart';
import '../../module/review_models_params/add_review_params.dart';
import '../../review_repository/models/review.dart';

part 'review_state.dart';
part 'review_cubit.freezed.dart';

class ReviewCubit extends Cubit<ReviewState> {
  final AddReviewUseCase addReviewUseCase;
  final GetAllReviewsUseCase getAllReviewsUseCase;
  final GetReviewsFromAPlaceUseCase getReviewsFromAPlaceUseCase;
  ReviewCubit(
      {required this.addReviewUseCase,
      required this.getAllReviewsUseCase,
      required this.getReviewsFromAPlaceUseCase})
      : super(const ReviewState.initial());

  Future<void> addReview(Review review, String placeId) async {
    emit(const ReviewState.loading());
    try {
      await addReviewUseCase(AddReviewParams(review: review, placeId: placeId));
      emit(ReviewState.loaded(await getReviewsFromAPlaceUseCase(placeId)));
    } catch (e) {
      emit(ReviewState.error(e.toString()));
    }
  }

  Future<void> getReviews() async {
    emit(const ReviewState.loading());
    try {
      final reviews = await getAllReviewsUseCase(NoParams());
      emit(ReviewState.loaded(reviews));
    } catch (e) {
      emit(ReviewState.error(e.toString()));
    }
  }
}
