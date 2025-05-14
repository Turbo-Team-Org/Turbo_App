import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:turbo/app/core/theme/app_themes.dart';
import 'package:turbo/app/core/theme/theme_cubit.dart';
import 'package:turbo/app/core/theme/theme_state.dart';
import 'package:turbo/app/image_management/presentation/cubit/image_management_cubit.dart';
import 'package:turbo/app/routes/guards/authentication_guards.dart';
import 'package:turbo/authentication/state_managament/auth_cubit/cubit/auth_cubit_cubit.dart';
import 'package:turbo/authentication/state_managament/sign_in_cubit/cubit/sign_in_cubit.dart';
import 'package:turbo/authentication/state_managament/sign_out_cubit/cubit/sign_out_cubit.dart';
import 'package:turbo/authentication/state_managament/sign_up_cubit/cubit/sign_up_cubit.dart';
import 'package:turbo/categories/state_management/category_bloc/category_cubit/cubit/category_cubit.dart';
import 'package:turbo/location/state_management/location_bloc/cubit/location_cubit.dart';
import 'package:turbo/places/state_management/place_bloc/cubit/place_cubit.dart';
import 'package:turbo/events/state_management/event_bloc/cubit/event_cubit.dart';

import '../../../boostrap.dart';
import '../../../favorites/state_management/cubit/favorite_cubit.dart';
import '../../../reviews/state_management/cubit/review_cubit.dart';
import '../../routes/router/app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: sl<SignInCubit>()),
        BlocProvider.value(value: sl<AuthCubit>()),
        BlocProvider.value(value: sl<PlaceCubit>()..getPlaces()),
        BlocProvider.value(value: sl<ReviewCubit>()),
        BlocProvider.value(value: sl<FavoriteCubit>()),
        BlocProvider.value(value: sl<SignOutCubit>()),
        BlocProvider.value(value: sl<SignUpCubit>()),
        BlocProvider.value(value: sl<LocationCubit>()),
        BlocProvider.value(value: sl<EventCubit>()),
        BlocProvider.value(value: sl<ThemeCubit>()),
        BlocProvider.value(value: sl<CategoryCubit>()),
        BlocProvider.value(value: sl<ImageManagementCubit>()),
      ],
      child: BlocListener<AuthCubit, AuthCubitState>(
        listenWhen: (previous, current) => previous != current,
        listener: (context, state) {
          print("🚀 MyApp - AuthCubit cambió de estado: $state");
        },
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    print("🚀 AppView - Construyendo AppView");
    final authCubit = context.read<AuthCubit>();
    print("🚀 AppView - Estado actual de AuthCubit: ${authCubit.state}");

    final appRouter = AppRouter(authGuard: AuthGuard(authCubit));

    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        final themeMode =
            (themeState is ThemeLoaded)
                ? (themeState.isDarkMode ? ThemeMode.dark : ThemeMode.light)
                : ThemeMode.system;

        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: AppThemes.lightTheme(),
          darkTheme: AppThemes.darkTheme(),
          themeMode: themeMode,
          routerConfig: appRouter.config(
            // Habilita registros de depuración para el router
            navigatorObservers: () => [_NavigationObserver()],
          ),
          builder: (context, child) {
            print("🚀 AppView - Builder llamado");
            return child ?? const SizedBox();
          },
        );
      },
    );
  }
}

// Observador para registrar eventos de navegación
class _NavigationObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    print(
      '🧭 Navegación: Pushed ${route.settings.name} (from: ${previousRoute?.settings.name})',
    );
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    print(
      '🧭 Navegación: Popped ${route.settings.name} (to: ${previousRoute?.settings.name})',
    );
    super.didPop(route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    print(
      '🧭 Navegación: Replaced ${oldRoute?.settings.name} → ${newRoute?.settings.name}',
    );
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    print('🧭 Navegación: Removed ${route.settings.name}');
    super.didRemove(route, previousRoute);
  }
}
