import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:turbo/users/domain/user_profile.dart';
import 'package:turbo/users/module/update_user_profile_use_case.dart';
import 'package:turbo/users/module/get_user_profile_use_case.dart';
import 'package:turbo/users/state_management/profile_cubit/profile_cubit.dart';

class MockGetUserProfileUseCase extends Mock implements GetUserProfileUseCase {}

class MockUpdateUserProfileUseCase extends Mock
    implements UpdateUserProfileUseCase {}

void main() {
  late UserProfile sampleProfile;

  setUpAll(() {
    registerFallbackValue(const UpdateUserProfileParams(displayName: 'fb'));
  });

  setUp(() {
    sampleProfile = const UserProfile(
      uid: 'u1',
      email: 'a@b.com',
      displayName: 'Ana',
      photoUrl: null,
      favoritesCount: 2,
      reservationsCount: 0,
      reviewsCount: 3,
    );
  });

  group('ProfileCubit', () {
    late MockGetUserProfileUseCase mockGet;
    late MockUpdateUserProfileUseCase mockUpdate;
    late ProfileCubit cubit;

    setUp(() {
      mockGet = MockGetUserProfileUseCase();
      mockUpdate = MockUpdateUserProfileUseCase();
      cubit = ProfileCubit(
        getUserProfileUseCase: mockGet,
        updateUserProfileUseCase: mockUpdate,
      );
    });

    test('starts with ProfileInitial', () {
      expect(cubit.state, const ProfileState.initial());
    });

    blocTest<ProfileCubit, ProfileState>(
      'emits [Loading, Loaded] when loadProfile succeeds',
      build: () {
        when(() => mockGet()).thenAnswer((_) async => sampleProfile);
        return ProfileCubit(
          getUserProfileUseCase: mockGet,
          updateUserProfileUseCase: mockUpdate,
        );
      },
      act: (c) => c.loadProfile(),
      expect: () => [
        const ProfileState.loading(),
        ProfileState.loaded(profile: sampleProfile),
      ],
    );

    blocTest<ProfileCubit, ProfileState>(
      'emits [Loading, Error] when loadProfile fails',
      build: () {
        when(() => mockGet()).thenThrow(Exception('network'));
        return ProfileCubit(
          getUserProfileUseCase: mockGet,
          updateUserProfileUseCase: mockUpdate,
        );
      },
      act: (c) => c.loadProfile(),
      expect: () => [
        const ProfileState.loading(),
        isA<ProfileError>(),
      ],
    );

    blocTest<ProfileCubit, ProfileState>(
      'emits [Updating, UpdateSuccess] when updateProfile succeeds',
      build: () {
        when(() => mockUpdate(any())).thenAnswer((_) async => sampleProfile);
        return ProfileCubit(
          getUserProfileUseCase: mockGet,
          updateUserProfileUseCase: mockUpdate,
        );
      },
      act: (c) => c.updateProfile(
            const UpdateUserProfileParams(displayName: 'Ana'),
          ),
      expect: () => [
        const ProfileState.updating(),
        ProfileState.updateSuccess(profile: sampleProfile),
      ],
    );

    blocTest<ProfileCubit, ProfileState>(
      'emits [Updating, Error] when updateProfile fails',
      build: () {
        when(() => mockUpdate(any())).thenThrow(Exception('fail'));
        return ProfileCubit(
          getUserProfileUseCase: mockGet,
          updateUserProfileUseCase: mockUpdate,
        );
      },
      act: (c) => c.updateProfile(
            const UpdateUserProfileParams(displayName: 'Ana'),
          ),
      expect: () => [
        const ProfileState.updating(),
        isA<ProfileError>(),
      ],
    );
  });
}
