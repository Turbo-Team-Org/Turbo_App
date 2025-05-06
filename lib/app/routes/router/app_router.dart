import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:turbo/app/routes/guards/authentication_guards.dart';
import 'package:turbo/app/routes/router/app_router.gr.dart';
import 'package:turbo/authentication/presentation/screens/aut_screens.dart';
import 'package:turbo/categories/presentation/screens/categories_screen.dart';
import 'package:turbo/categories/presentation/screens/category_details_screen.dart';
import 'package:turbo/events/presentation/screens/events_screen.dart';

import '../../../authentication/presentation/screens/splash_screen.dart';
import '../../../favorites/presentation/screens/favorite_screen.dart';
import '../../../places/place_repository/models/place/place.dart';
import '../../../places/presentation/screens/business_detail.dart';
import '../../../places/presentation/screens/feed_screen.dart';
import '../../../places/presentation/screens/places_showcase_screen.dart';
import '../../../users/presentation/screens/profile_screen.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  final AuthGuard authGuard;

  AppRouter({required this.authGuard});

  @override
  RouteType get defaultRouteType => RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, path: '/'),
    AutoRoute(page: SignUpRoute.page, path: '/sign-up'),
    AutoRoute(page: SignInRoute.page, path: '/sign-in'),

    AutoRoute(page: BusinessDetailsRoute.page, path: '/business-detail'),
    AutoRoute(page: PlacesShowcaseRoute.page, path: '/places-showcase'),

    // Rutas de categorías
    AutoRoute(page: CategoriesRoute.page, path: '/categories'),
    AutoRoute(page: CategoryDetailsRoute.page, path: '/category/:categoryId'),

    AutoRoute(
      path: '/home',
      page: BottomNavShellWidget.page,
      guards: [authGuard],
      children: [
        AutoRoute(path: 'feed', page: FeedRoute.page, initial: true),
        AutoRoute(path: 'favorites', page: FavoritesRoute.page),
        AutoRoute(path: 'profile', page: ProfileRoute.page),
        AutoRoute(path: 'events', page: EventsRoute.page),
      ],
    ),
  ];
}
