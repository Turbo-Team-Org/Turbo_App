import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../app/core/no_params.dart';
import '../../module/add_review_use_case.dart';
import '../../module/delete_review_use_case.dart';
import '../../module/get_all_reviews_use_case.dart';
import '../../module/get_reviews_from_a_place_use_case.dart';
import '../../module/review_models_params/add_review_params.dart';
import '../../module/review_models_params/delete_review_params.dart';
import '../../module/update_review_use_case.dart';
import 'package:core/core.dart';

part 'review_state.dart';
part 'review_cubit.freezed.dart';

class ReviewCubit extends Cubit<ReviewState> {
  final AddReviewUseCase addReviewUseCase;
  final GetAllReviewsUseCase getAllReviewsUseCase;
  final GetReviewsFromAPlaceUseCase getReviewsFromAPlaceUseCase;
  final UpdateReviewUseCase updateReviewUseCase;
  final DeleteReviewUseCase deleteReviewUseCase;

  ReviewCubit({
    required this.addReviewUseCase,
    required this.getAllReviewsUseCase,
    required this.getReviewsFromAPlaceUseCase,
    required this.updateReviewUseCase,
    required this.deleteReviewUseCase,
  }) : super(const ReviewState.initial());

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

  Future<void> getReviewsFromAPlace(String placeId) async {
    emit(const ReviewState.loading());
    try {
      final reviews = await getReviewsFromAPlaceUseCase(placeId);
      emit(ReviewState.loaded(reviews));
    } catch (e) {
      emit(ReviewState.error(e.toString()));
    }
  }

  Future<void> updateReview(Review review, String placeId) async {
    emit(const ReviewState.loading());
    try {
      await updateReviewUseCase(review);
      emit(ReviewState.loaded(await getReviewsFromAPlaceUseCase(placeId)));
    } catch (e) {
      emit(ReviewState.error(e.toString()));
    }
  }

  Future<void> deleteReview(String reviewId, String placeId) async {
    emit(const ReviewState.loading());
    try {
      await deleteReviewUseCase(
        DeleteReviewParams(reviewId: reviewId, placeId: placeId),
      );
      emit(ReviewState.loaded(await getReviewsFromAPlaceUseCase(placeId)));
    } catch (e) {
      emit(ReviewState.error(e.toString()));
    }
  }
}
