import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turbo_ui/turbo_ui.dart';
import 'package:turbo/app/core/theme/theme_cubit.dart';
import 'package:turbo/app/image_management/presentation/cubit/image_management_cubit.dart';
import 'package:turbo/app/routes/guards/authentication_guards.dart';
import 'package:turbo/authentication/state_management/auth_cubit/cubit/auth_cubit_cubit.dart';
import 'package:turbo/authentication/state_management/sign_in_cubit/cubit/sign_in_cubit.dart';
import 'package:turbo/authentication/state_management/sign_out_cubit/cubit/sign_out_cubit.dart';
import 'package:turbo/authentication/state_management/sign_up_cubit/cubit/sign_up_cubit.dart';
import 'package:turbo/categories/state_management/category_cubit.dart';
import 'package:turbo/location/state_management/location_bloc/cubit/location_cubit.dart';
import 'package:turbo/places/state_management/place_bloc/cubit/place_cubit.dart';
import 'package:turbo/places/state_management/place_search_cubit/places_search_cubit.dart';
import 'package:turbo/events/state_management/event_bloc/cubit/event_cubit.dart';
import 'package:turbo/app/cache/presentation/cubit/sync_cubit.dart';
import 'package:turbo/reservations/state_management/booking_cubit/booking_cubit.dart';
import 'package:turbo/reservations/state_management/booking_form_cubit/booking_form_cubit.dart';
import 'package:turbo/reservations/state_management/my_reservations_cubit/my_reservations_cubit.dart';
import 'package:turbo/theme_selector/theme_selector.dart';

import '../../../boostrap.dart';
import '../../../favorites/state_management/cubit/favorite_cubit.dart';
import '../../../reviews/state_management/cubit/review_cubit.dart';
import '../../routes/router/app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: sl<SignInCubit>()),
        BlocProvider.value(value: sl<AuthCubit>()),
        BlocProvider.value(value: sl<PlaceCubit>()..getPlaces()),
        BlocProvider(create: (context) => sl<PlacesSearchCubit>()),
        BlocProvider.value(value: sl<ReviewCubit>()),
        BlocProvider.value(value: sl<FavoriteCubit>()),
        BlocProvider.value(value: sl<SignOutCubit>()),
        BlocProvider.value(value: sl<SignUpCubit>()),
        BlocProvider.value(value: sl<LocationCubit>()),
        BlocProvider.value(value: sl<EventCubit>()),
        BlocProvider.value(value: sl<ThemeCubit>()),
        BlocProvider.value(value: sl<CategoryCubit>()),
        BlocProvider.value(value: sl<ImageManagementCubit>()),
        BlocProvider.value(value: sl<SyncCubit>()),
        // Nuevo ThemeBloc con persistencia
        BlocProvider.value(value: sl<ThemeBloc>()),

        // Reservations BlocProviders
        BlocProvider(create: (context) => sl<BookingCubit>()),
        BlocProvider(create: (context) => sl<BookingFormCubit>()),
        BlocProvider(create: (context) => sl<MyReservationsCubit>()),
      ],
      child: BlocListener<AuthCubit, AuthCubitState>(
        listenWhen: (previous, current) => previous != current,
        listener: (context, state) {
          debugPrint("MyApp - AuthCubit cambió de estado: $state");
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
    debugPrint("AppView - Construyendo AppView");
    final authCubit = context.read<AuthCubit>();
    debugPrint("AppView - Estado actual de AuthCubit: ${authCubit.state}");

    final appRouter = AppRouter(authGuard: AuthGuard(authCubit));

    // Usar el nuevo ThemeBloc con TurboTheme
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          // Usar los nuevos TurboThemes
          theme: TurboTheme.light,
          darkTheme: TurboTheme.dark,
          themeMode: themeState.themeMode,
          routerConfig: appRouter.config(
            navigatorObservers: () => [_NavigationObserver()],
          ),
          builder: (context, child) {
            debugPrint("AppView - Builder llamado");
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
    debugPrint(
      'Navegación: Pushed ${route.settings.name} (from: ${previousRoute?.settings.name})',
    );
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint(
      'Navegación: Popped ${route.settings.name} (to: ${previousRoute?.settings.name})',
    );
    super.didPop(route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    debugPrint(
      'Navegación: Replaced ${oldRoute?.settings.name} → ${newRoute?.settings.name}',
    );
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint('Navegación: Removed ${route.settings.name}');
    super.didRemove(route, previousRoute);
  }
}
