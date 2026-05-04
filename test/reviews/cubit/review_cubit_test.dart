import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:core/core.dart';
import 'package:turbo/app/core/no_params.dart';
import 'package:turbo/reviews/module/add_review_use_case.dart';
import 'package:turbo/reviews/module/delete_review_use_case.dart';
import 'package:turbo/reviews/module/get_all_reviews_use_case.dart';
import 'package:turbo/reviews/module/get_reviews_from_a_place_use_case.dart';
import 'package:turbo/reviews/module/review_models_params/add_review_params.dart';
import 'package:turbo/reviews/module/review_models_params/delete_review_params.dart';
import 'package:turbo/reviews/module/update_review_use_case.dart';
import 'package:turbo/reviews/state_management/cubit/review_cubit.dart';

class MockAddReviewUseCase extends Mock implements AddReviewUseCase {}

class MockGetAllReviewsUseCase extends Mock implements GetAllReviewsUseCase {}

class MockGetReviewsFromAPlaceUseCase extends Mock
    implements GetReviewsFromAPlaceUseCase {}

class MockUpdateReviewUseCase extends Mock implements UpdateReviewUseCase {}

class MockDeleteReviewUseCase extends Mock implements DeleteReviewUseCase {}

void main() {
  late Review sampleReview;

  setUpAll(() {
    registerFallbackValue(NoParams());
    final fallbackReview = Review(
      id: 'fb',
      userId: 'u',
      userName: 'n',
      userAvatar: '',
      comment: 'c',
      rating: 3,
      date: DateTime(2024),
    );
    registerFallbackValue(fallbackReview);
    registerFallbackValue(AddReviewParams(review: fallbackReview, placeId: 'p'));
    registerFallbackValue(
      DeleteReviewParams(reviewId: 'r', placeId: 'p'),
    );
  });

  setUp(() {
    sampleReview = Review(
      id: 'r1',
      userId: 'u1',
      userName: 'Tester',
      userAvatar: '',
      comment: 'Muy buen lugar para visitar',
      rating: 4,
      date: DateTime(2024, 6, 15),
    );
  });

  group('ReviewCubit', () {
    late MockAddReviewUseCase mockAdd;
    late MockGetAllReviewsUseCase mockGetAll;
    late MockGetReviewsFromAPlaceUseCase mockGetPlace;
    late MockUpdateReviewUseCase mockUpdate;
    late MockDeleteReviewUseCase mockDelete;
    late ReviewCubit cubit;

    setUp(() {
      mockAdd = MockAddReviewUseCase();
      mockGetAll = MockGetAllReviewsUseCase();
      mockGetPlace = MockGetReviewsFromAPlaceUseCase();
      mockUpdate = MockUpdateReviewUseCase();
      mockDelete = MockDeleteReviewUseCase();
      cubit = ReviewCubit(
        addReviewUseCase: mockAdd,
        getAllReviewsUseCase: mockGetAll,
        getReviewsFromAPlaceUseCase: mockGetPlace,
        updateReviewUseCase: mockUpdate,
        deleteReviewUseCase: mockDelete,
      );
    });

    tearDown(() {
      cubit.close();
    });

    test('estado inicial es ReviewInitial', () {
      expect(cubit.state, const ReviewState.initial());
    });

    blocTest<ReviewCubit, ReviewState>(
      'getReviewsFromAPlace emite Loading y Loaded con listado',
      build: () {
        when(() => mockGetPlace('place-1')).thenAnswer((_) async => [sampleReview]);
        return cubit;
      },
      act: (c) => c.getReviewsFromAPlace('place-1'),
      expect:
          () => [
            const ReviewState.loading(),
            ReviewState.loaded([sampleReview]),
          ],
      verify: (_) {
        verify(() => mockGetPlace('place-1')).called(1);
      },
    );

    blocTest<ReviewCubit, ReviewState>(
      'getReviewsFromAPlace emite Error si falla',
      build: () {
        when(
          () => mockGetPlace('bad'),
        ).thenThrow(Exception('network'));
        return cubit;
      },
      act: (c) => c.getReviewsFromAPlace('bad'),
      expect:
          () => [
            const ReviewState.loading(),
            ReviewState.error('Exception: network'),
          ],
    );

    blocTest<ReviewCubit, ReviewState>(
      'addReview recarga reseñas del lugar',
      build: () {
        when(
          () => mockAdd(any()),
        ).thenAnswer((_) async {});
        when(
          () => mockGetPlace('p1'),
        ).thenAnswer((_) async => [sampleReview]);
        return cubit;
      },
      act: (c) => c.addReview(sampleReview, 'p1'),
      expect:
          () => [
            const ReviewState.loading(),
            ReviewState.loaded([sampleReview]),
          ],
    );

    blocTest<ReviewCubit, ReviewState>(
      'updateReview recarga reseñas del lugar',
      build: () {
        when(() => mockUpdate(any())).thenAnswer((_) async {});
        when(
          () => mockGetPlace('p1'),
        ).thenAnswer((_) async => [sampleReview]);
        return cubit;
      },
      act: (c) => c.updateReview(sampleReview, 'p1'),
      expect:
          () => [
            const ReviewState.loading(),
            ReviewState.loaded([sampleReview]),
          ],
    );

    blocTest<ReviewCubit, ReviewState>(
      'deleteReview recarga reseñas del lugar',
      build: () {
        when(() => mockDelete(any())).thenAnswer((_) async {});
        when(() => mockGetPlace('p1')).thenAnswer((_) async => []);
        return cubit;
      },
      act: (c) => c.deleteReview('r1', 'p1'),
      expect:
          () => [
            const ReviewState.loading(),
            const ReviewState.loaded([]),
          ],
    );
  });
}
