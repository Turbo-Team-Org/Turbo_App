import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:core/core.dart';
import 'package:turbo/app/l10n/l10n.dart';
import 'package:turbo/authentication/state_management/auth_cubit/cubit/auth_cubit_cubit.dart';
import 'package:turbo/reviews/module/add_review_use_case.dart';
import 'package:turbo/reviews/module/delete_review_use_case.dart';
import 'package:turbo/reviews/module/get_all_reviews_use_case.dart';
import 'package:turbo/reviews/module/get_reviews_from_a_place_use_case.dart';
import 'package:turbo/reviews/module/update_review_use_case.dart';
import 'package:turbo/reviews/presentation/screens/add_review_screen.dart';
import 'package:turbo/reviews/state_management/cubit/review_cubit.dart';

import 'package:turbo/app/core/no_params.dart';
import 'package:turbo/reviews/module/review_models_params/add_review_params.dart';
import 'package:turbo/reviews/module/review_models_params/delete_review_params.dart';

class MockAuthCubit extends Mock implements AuthCubit {}

class MockAddReviewUseCase extends Mock implements AddReviewUseCase {}

class MockGetAllReviewsUseCase extends Mock implements GetAllReviewsUseCase {}

class MockGetReviewsFromAPlaceUseCase extends Mock
    implements GetReviewsFromAPlaceUseCase {}

class MockUpdateReviewUseCase extends Mock implements UpdateReviewUseCase {}

class MockDeleteReviewUseCase extends Mock implements DeleteReviewUseCase {}

void main() {
  setUpAll(() {
    registerFallbackValue(NoParams());
    final r = Review(
      id: 'fb',
      userId: 'u',
      userName: 'n',
      userAvatar: '',
      comment: 'c',
      rating: 3,
      date: DateTime(2024),
    );
    registerFallbackValue(r);
    registerFallbackValue(AddReviewParams(review: r, placeId: 'p'));
    registerFallbackValue(DeleteReviewParams(reviewId: 'r', placeId: 'p'));
  });

  testWidgets('muestra título de nueva reseña', (tester) async {
    final cubit = ReviewCubit(
      addReviewUseCase: MockAddReviewUseCase(),
      getAllReviewsUseCase: MockGetAllReviewsUseCase(),
      getReviewsFromAPlaceUseCase: MockGetReviewsFromAPlaceUseCase(),
      updateReviewUseCase: MockUpdateReviewUseCase(),
      deleteReviewUseCase: MockDeleteReviewUseCase(),
    );

    final auth = MockAuthCubit();
    when(() => auth.state).thenReturn(const AuthCubitState.unauthenticated());
    when(() => auth.stream).thenAnswer(
      (_) => Stream.value(const AuthCubitState.unauthenticated()),
    );

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('es'),
        home: MultiBlocProvider(
          providers: [
            BlocProvider<AuthCubit>.value(value: auth),
            BlocProvider<ReviewCubit>.value(value: cubit),
          ],
          child: const AddReviewScreen(placeId: 'p1'),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Nueva reseña'), findsOneWidget);
    await cubit.close();
  });
}
