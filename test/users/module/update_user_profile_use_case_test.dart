import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:turbo/users/module/update_user_profile_use_case.dart';

class _MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class _MockAuthenticationRepositoryWithUpdate extends Mock
    implements AuthenticationRepository {
  Future<AuthUser> updateUserProfile({
    String? displayName,
    String? photoUrl,
  }) {
    return super.noSuchMethod(
          Invocation.method(
            #updateUserProfile,
            [],
            {#displayName: displayName, #photoUrl: photoUrl},
          ),
        )
        as Future<AuthUser>;
  }
}

void main() {
  late _MockAuthenticationRepository authenticationRepository;
  late UpdateUserProfileUseCase useCase;

  setUp(() {
    authenticationRepository = _MockAuthenticationRepository();
    useCase = UpdateUserProfileUseCase(
      authenticationRepository: authenticationRepository,
    );
  });

  test('usa updateUserProfile cuando el repositorio lo expone', () async {
    final authWithUpdate = _MockAuthenticationRepositoryWithUpdate();
    useCase = UpdateUserProfileUseCase(
      authenticationRepository: authWithUpdate,
    );
    final updatedUser = AuthUser(
      uid: 'u1',
      email: 'new@turbo.cu',
      createdAt: DateTime(2026, 1, 1),
      displayName: 'Nuevo Nombre',
      photoUrl: 'https://cdn.turbo.cu/avatar.png',
      favorites: const [99],
    );

    when(
      () => authWithUpdate.updateUserProfile(
        displayName: 'Nuevo Nombre',
        photoUrl: 'https://cdn.turbo.cu/avatar.png',
      ),
    ).thenAnswer((_) async => updatedUser);

    final result = await useCase(
      const UpdateUserProfileParams(
        displayName: 'Nuevo Nombre',
        photoUrl: 'https://cdn.turbo.cu/avatar.png',
      ),
    );

    expect(result.uid, 'u1');
    expect(result.displayName, 'Nuevo Nombre');
    expect(result.photoUrl, 'https://cdn.turbo.cu/avatar.png');
    expect(result.favoritesCount, 1);
    verify(
      () => authWithUpdate.updateUserProfile(
        displayName: 'Nuevo Nombre',
        photoUrl: 'https://cdn.turbo.cu/avatar.png',
      ),
    ).called(1);
  });

  test('hace fallback a updateDisplayName cuando no existe updateUserProfile', () async {
    final currentUser = AuthUser(
      uid: 'u2',
      email: 'legacy@turbo.cu',
      createdAt: DateTime(2026, 1, 1),
      displayName: 'Legacy',
    );
    when(() => authenticationRepository.updateDisplayName('Legacy Name'))
        .thenAnswer((_) async {});
    when(() => authenticationRepository.getCurrentUser())
        .thenAnswer((_) async => currentUser);

    final result = await useCase(
      const UpdateUserProfileParams(displayName: 'Legacy Name'),
    );

    expect(result.uid, 'u2');
    expect(result.displayName, 'Legacy');
    verify(() => authenticationRepository.updateDisplayName('Legacy Name'))
        .called(1);
    verify(() => authenticationRepository.getCurrentUser()).called(1);
  });
}
