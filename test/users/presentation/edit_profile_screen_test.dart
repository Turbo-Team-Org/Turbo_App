import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:auto_route/auto_route.dart';
import 'package:turbo/app/image_management/presentation/cubit/image_management_cubit.dart';
import 'package:turbo/app/image_management/presentation/cubit/image_management_state.dart';
import 'package:turbo/app/l10n/l10n.dart';
import 'package:turbo/authentication/state_management/auth_cubit/cubit/auth_cubit_cubit.dart';
import 'package:turbo/users/domain/user_profile.dart';
import 'package:turbo/users/presentation/screens/edit_profile_screen.dart';
import 'package:turbo/users/state_management/profile_cubit/profile_cubit.dart';
import 'package:core/core.dart' show AuthUser;

class MockProfileCubit extends Mock implements ProfileCubit {}

class MockAuthCubit extends Mock implements AuthCubit {}

class MockImageManagementCubit extends Mock implements ImageManagementCubit {}
class MockStackRouter extends Mock implements StackRouter {}

void main() {
  setUpAll(() {
    registerFallbackValue(ImageSource.gallery);
  });

  final authUser = AuthUser(
    uid: '1',
    email: 'e@test.com',
    displayName: 'Tester',
    favorites: const [],
    createdAt: DateTime(2025),
  );
  final authUserWithoutName = AuthUser(
    uid: '1',
    email: 'e@test.com',
    displayName: null,
    favorites: const [],
    createdAt: DateTime(2025),
  );

  final profile = UserProfile.fromAuthUser(authUser);

  testWidgets('validación: nombre corto muestra error', (tester) async {
    final profileCubit = MockProfileCubit();
    when(() => profileCubit.state).thenReturn(
      ProfileState.loaded(profile: profile),
    );
    when(() => profileCubit.stream).thenAnswer(
      (_) => Stream.value(ProfileState.loaded(profile: profile)),
    );

    final auth = MockAuthCubit();
    when(() => auth.state).thenReturn(AuthCubitState.authenticated(authUser));
    when(() => auth.stream).thenAnswer(
      (_) => Stream.value(AuthCubitState.authenticated(authUser)),
    );

    final imgCubit = MockImageManagementCubit();
    when(() => imgCubit.state).thenReturn(const ImageManagementState.initial());
    when(() => imgCubit.stream).thenAnswer(
      (_) => Stream.value(const ImageManagementState.initial()),
    );

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('es'),
        home: MultiBlocProvider(
          providers: [
            BlocProvider<ProfileCubit>.value(value: profileCubit),
            BlocProvider<AuthCubit>.value(value: auth),
            BlocProvider<ImageManagementCubit>.value(value: imgCubit),
          ],
          child: const EditProfileScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField), 'a');
    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();

    expect(
      find.text('El nombre debe tener al menos 2 caracteres'),
      findsOneWidget,
    );
  });

  testWidgets(
    'no cierra pantalla en ProfileUpdateSuccess si no viene de guardar',
    (tester) async {
      final profileCubit = MockProfileCubit();
      when(() => profileCubit.state).thenReturn(
        ProfileState.loaded(profile: profile),
      );
      when(() => profileCubit.stream).thenAnswer(
        (_) => Stream.value(ProfileState.updateSuccess(profile: profile)),
      );

      final auth = MockAuthCubit();
      when(() => auth.state).thenReturn(AuthCubitState.authenticated(authUser));
      when(() => auth.stream).thenAnswer(
        (_) => Stream.value(AuthCubitState.authenticated(authUser)),
      );

      final imgCubit = MockImageManagementCubit();
      when(() => imgCubit.state).thenReturn(const ImageManagementState.initial());
      when(() => imgCubit.stream).thenAnswer(
        (_) => Stream.value(const ImageManagementState.initial()),
      );

      final router = MockStackRouter();
      when(() => router.maybePop<void>(any())).thenAnswer((_) async => true);

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('es'),
          home: StackRouterScope(
            stateHash: 0,
            controller: router,
            child: MultiBlocProvider(
              providers: [
                BlocProvider<ProfileCubit>.value(value: profileCubit),
                BlocProvider<AuthCubit>.value(value: auth),
                BlocProvider<ImageManagementCubit>.value(value: imgCubit),
              ],
              child: const EditProfileScreen(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      verifyNever(() => router.maybePop<void>(any()));
    },
  );

  testWidgets(
    'prefill de nombre cuando el perfil carga de forma asíncrona',
    (tester) async {
      final loadedProfile = profile.copyWith(displayName: 'Nombre Cargado');
      final profileCubit = MockProfileCubit();
      when(() => profileCubit.state).thenReturn(const ProfileState.initial());
      when(() => profileCubit.stream).thenAnswer(
        (_) => Stream.value(ProfileState.loaded(profile: loadedProfile)),
      );

      final auth = MockAuthCubit();
      when(() => auth.state)
          .thenReturn(AuthCubitState.authenticated(authUserWithoutName));
      when(() => auth.stream).thenAnswer(
        (_) => Stream.value(AuthCubitState.authenticated(authUserWithoutName)),
      );

      final imgCubit = MockImageManagementCubit();
      when(() => imgCubit.state).thenReturn(const ImageManagementState.initial());
      when(() => imgCubit.stream).thenAnswer(
        (_) => Stream.value(const ImageManagementState.initial()),
      );

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('es'),
          home: MultiBlocProvider(
            providers: [
              BlocProvider<ProfileCubit>.value(value: profileCubit),
              BlocProvider<AuthCubit>.value(value: auth),
              BlocProvider<ImageManagementCubit>.value(value: imgCubit),
            ],
            child: const EditProfileScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Nombre Cargado'), findsOneWidget);
    },
  );

  testWidgets(
    'tap en avatar abre sheet y galería llama pickAndCompressImage(gallery)',
    (tester) async {
      final profileCubit = MockProfileCubit();
      when(() => profileCubit.state).thenReturn(
        ProfileState.loaded(profile: profile),
      );
      when(() => profileCubit.stream).thenAnswer(
        (_) => Stream.value(ProfileState.loaded(profile: profile)),
      );

      final auth = MockAuthCubit();
      when(() => auth.state).thenReturn(AuthCubitState.authenticated(authUser));
      when(() => auth.stream).thenAnswer(
        (_) => Stream.value(AuthCubitState.authenticated(authUser)),
      );

      final imgCubit = MockImageManagementCubit();
      when(() => imgCubit.state).thenReturn(const ImageManagementState.initial());
      when(() => imgCubit.stream).thenAnswer(
        (_) => Stream.value(const ImageManagementState.initial()),
      );
      when(() => imgCubit.pickAndCompressImage(any())).thenAnswer((_) async {});

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('es'),
          home: MultiBlocProvider(
            providers: [
              BlocProvider<ProfileCubit>.value(value: profileCubit),
              BlocProvider<AuthCubit>.value(value: auth),
              BlocProvider<ImageManagementCubit>.value(value: imgCubit),
            ],
            child: const EditProfileScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.camera_alt));
      await tester.pumpAndSettle();

      expect(find.text('Galería'), findsOneWidget);
      await tester.tap(find.text('Galería'));
      await tester.pumpAndSettle();

      verify(() => imgCubit.pickAndCompressImage(ImageSource.gallery)).called(1);
    },
  );

  testWidgets(
    'tap en avatar y cámara llama pickAndCompressImage(camera)',
    (tester) async {
      final profileCubit = MockProfileCubit();
      when(() => profileCubit.state).thenReturn(
        ProfileState.loaded(profile: profile),
      );
      when(() => profileCubit.stream).thenAnswer(
        (_) => Stream.value(ProfileState.loaded(profile: profile)),
      );

      final auth = MockAuthCubit();
      when(() => auth.state).thenReturn(AuthCubitState.authenticated(authUser));
      when(() => auth.stream).thenAnswer(
        (_) => Stream.value(AuthCubitState.authenticated(authUser)),
      );

      final imgCubit = MockImageManagementCubit();
      when(() => imgCubit.state).thenReturn(const ImageManagementState.initial());
      when(() => imgCubit.stream).thenAnswer(
        (_) => Stream.value(const ImageManagementState.initial()),
      );
      when(() => imgCubit.pickAndCompressImage(any())).thenAnswer((_) async {});

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('es'),
          home: MultiBlocProvider(
            providers: [
              BlocProvider<ProfileCubit>.value(value: profileCubit),
              BlocProvider<AuthCubit>.value(value: auth),
              BlocProvider<ImageManagementCubit>.value(value: imgCubit),
            ],
            child: const EditProfileScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.camera_alt));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Cámara'));
      await tester.pumpAndSettle();

      verify(() => imgCubit.pickAndCompressImage(ImageSource.camera)).called(1);
    },
  );
}
