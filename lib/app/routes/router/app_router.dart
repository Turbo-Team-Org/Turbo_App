import 'package:auto_route/auto_route.dart';

import 'package:turbo/app/routes/guards/authentication_guards.dart';
import 'package:turbo/app/routes/router/app_router.gr.dart';
import '../../presentation/screens/turbo_splash_screen.dart';

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

    // Rutas de categorías
    AutoRoute(
      path: '/home',
      page: BottomNavShellWidget.page,
      guards: [authGuard],
      children: [
        AutoRoute(path: 'feed', page: FeedRoute.page, initial: true),
        AutoRoute(
          path: 'categories',
          page: CategoriesRoute.page,
          children: [
            AutoRoute(path: ':categoryId', page: CategoryDetailsRoute.page),
          ],
        ),
        AutoRoute(path: 'events', page: EventsRoute.page),
        AutoRoute(path: 'favorites', page: FavoritesRoute.page),
        AutoRoute(path: 'profile', page: ProfileRoute.page),
      ],
    ),
  ];
}
