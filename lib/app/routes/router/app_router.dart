import 'package:auto_route/auto_route.dart';

import 'package:turbo/app/routes/guards/authentication_guards.dart';
import 'package:turbo/app/routes/router/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  final AuthGuard authGuard;

  AppRouter({required this.authGuard});

  @override
  RouteType get defaultRouteType => RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: TurboSplashRoute.page, path: '/'),
    AutoRoute(page: SignUpRoute.page, path: '/sign-up'),
    AutoRoute(page: SignInRoute.page, path: '/sign-in'),

    AutoRoute(page: BusinessDetailsRoute.page, path: '/business-detail'),
    AutoRoute(page: PlacesShowcaseRoute.page, path: '/places-showcase'),

    // Rutas de lugares y búsqueda
    AutoRoute(page: PlacesSearchRoute.page, path: '/places-search'),

    // Rutas de reservaciones
    AutoRoute(page: BookingRoute.page, path: '/booking'),
    AutoRoute(page: BookingFormRoute.page, path: '/booking-form'),
    AutoRoute(page: MyReservationsRoute.page, path: '/my-reservations'),
    AutoRoute(
      page: ReservationDetailsRoute.page,
      path: '/reservation-details/:reservationId',
    ),

    // Ruta independiente para detalles de categoría
    AutoRoute(page: CategoryDetailsRoute.page, path: '/category-details'),

    // Rutas de categorías
    AutoRoute(
      path: '/home',
      page: BottomNavShellWidget.page,
      guards: [authGuard],
      children: [
        AutoRoute(path: 'feed', page: FeedRoute.page, initial: true),
        AutoRoute(path: 'categories', page: CategoriesRoute.page),
        AutoRoute(path: 'events', page: EventsRoute.page),
        AutoRoute(path: 'favorites', page: FavoritesRoute.page),
        AutoRoute(path: 'profile', page: ProfileRoute.page),
      ],
    ),
  ];
}
