import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:turbo/app/l10n/l10n.dart';
import 'package:turbo/authentication/state_management/auth_cubit/cubit/auth_cubit_cubit.dart';
import 'package:turbo/authentication/state_management/sign_out_cubit/cubit/sign_out_cubit.dart';
import 'package:turbo/users/domain/user_profile.dart';
import 'package:turbo/users/presentation/screens/profile_screen.dart';
import 'package:turbo/users/state_management/profile_cubit/profile_cubit.dart';
import 'package:turbo/theme_selector/theme_selector.dart';
import 'package:core/core.dart' show AuthUser;

class MockProfileCubit extends Mock implements ProfileCubit {}

class MockAuthCubit extends Mock implements AuthCubit {}

class MockSignOutCubit extends Mock implements SignOutCubit {}

class MockThemeBloc extends Mock implements ThemeBloc {}

void main() {
  final profile = const UserProfile(
    uid: '1',
    email: 'e@test.com',
    displayName: 'Tester',
    favoritesCount: 1,
    reservationsCount: 2,
    reviewsCount: 3,
  );

  final authUser = AuthUser(
    uid: '1',
    email: 'e@test.com',
    displayName: 'Tester',
    favorites: const [],
    createdAt: DateTime(2025),
  );

  testWidgets('muestra nombre y correo en estado cargado', (tester) async {
    final profileCubit = MockProfileCubit();
    when(() => profileCubit.loadProfile()).thenAnswer((_) async {});
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

    final signOut = MockSignOutCubit();
    when(() => signOut.state).thenReturn(const SignOutState.initial());
    when(() => signOut.stream).thenAnswer(
      (_) => Stream.value(const SignOutState.initial()),
    );

    final themeBloc = MockThemeBloc();
    when(() => themeBloc.state).thenReturn(const ThemeState());
    when(() => themeBloc.stream).thenAnswer(
      (_) => Stream.value(const ThemeState()),
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
            BlocProvider<SignOutCubit>.value(value: signOut),
            BlocProvider<ThemeBloc>.value(value: themeBloc),
          ],
          child: const ProfileScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Tester'), findsOneWidget);
    expect(find.text('e@test.com'), findsOneWidget);
  });
}
