part of 'review_cubit.dart';

@freezed
sealed class ReviewState with _$ReviewState {
  const factory ReviewState.initial() = ReviewInitial;
  const factory ReviewState.loading() = ReviewLoading;
  const factory ReviewState.loaded(List<Review> reviews) = ReviewLoaded;
  const factory ReviewState.error(String message) = ReviewError;
}
