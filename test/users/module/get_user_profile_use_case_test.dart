import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:turbo/users/module/get_user_profile_use_case.dart';

class _MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class _MockReservationRepository extends Mock implements ReservationRepository {}

class _MockReviewRepository extends Mock implements ReviewRepository {}

void main() {
  late _MockAuthenticationRepository authenticationRepository;
  late _MockReservationRepository reservationRepository;
  late _MockReviewRepository reviewRepository;
  late GetUserProfileUseCase useCase;

  setUp(() {
    authenticationRepository = _MockAuthenticationRepository();
    reservationRepository = _MockReservationRepository();
    reviewRepository = _MockReviewRepository();
    useCase = GetUserProfileUseCase(
      authenticationRepository: authenticationRepository,
      reservationRepository: reservationRepository,
      reviewRepository: reviewRepository,
    );
  });

  test('retorna null cuando no hay usuario autenticado', () async {
    when(() => authenticationRepository.getCurrentUser())
        .thenAnswer((_) async => null);

    final result = await useCase();

    expect(result, isNull);
    verify(() => authenticationRepository.getCurrentUser()).called(1);
    verifyNever(() => reservationRepository.getUserReservations(any()));
    verifyNever(() => reviewRepository.getReviewsByUserId(any(), page: any(named: 'page'), limit: any(named: 'limit')));
  });

  test('construye perfil con conteos de reservas y reseñas', () async {
    final authUser = AuthUser(
      uid: 'u1',
      email: 'test@turbo.cu',
      createdAt: DateTime(2026, 1, 1),
      displayName: 'Turbo User',
      favorites: const [1, 2, 3],
    );
    when(() => authenticationRepository.getCurrentUser())
        .thenAnswer((_) async => authUser);
    when(() => reservationRepository.getUserReservations('u1'))
        .thenAnswer((_) async => <Reservation>[]);
    when(
      () => reviewRepository.getReviewsByUserId(
        'u1',
        page: 1,
        limit: 1,
      ),
    ).thenAnswer(
      (_) async => const PagedResult<Review>(
        items: <Review>[],
        totalCount: 7,
        currentPage: 1,
        pageSize: 1,
        totalPages: 7,
        hasNextPage: true,
        hasPreviousPage: false,
      ),
    );

    final result = await useCase();

    expect(result, isNotNull);
    expect(result!.uid, 'u1');
    expect(result.favoritesCount, 3);
    expect(result.reservationsCount, 0);
    expect(result.reviewsCount, 7);
  });
}
