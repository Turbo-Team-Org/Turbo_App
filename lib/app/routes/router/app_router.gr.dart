// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:flutter/material.dart' as _i11;
import 'package:turbo/app/view/widgets/bottom_nav_shield.dart' as _i1;
import 'package:turbo/authentication/presentation/screens/sign_in_screen.dart'
    as _i7;
import 'package:turbo/authentication/presentation/screens/sign_up_screen.dart'
    as _i8;
import 'package:turbo/authentication/presentation/screens/splash_screen.dart'
    as _i9;
import 'package:turbo/favorites/presentation/screens/favorite_screen.dart'
    as _i3;
import 'package:turbo/places/presentation/screens/business_detail.dart' as _i2;
import 'package:turbo/places/presentation/screens/feed_screen.dart' as _i4;
import 'package:turbo/places/presentation/screens/places_showcase_screen.dart'
    as _i5;
import 'package:turbo/users/presentation/screens/profile_screen.dart' as _i6;

/// generated route for
/// [_i1.BottomNavShellWidget]
class BottomNavShellWidget extends _i10.PageRouteInfo<void> {
  const BottomNavShellWidget({List<_i10.PageRouteInfo>? children})
    : super(BottomNavShellWidget.name, initialChildren: children);

  static const String name = 'BottomNavShellWidget';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i1.BottomNavShellWidget();
    },
  );
}

/// generated route for
/// [_i2.BusinessDetailsScreen]
class BusinessDetailsRoute
    extends _i10.PageRouteInfo<BusinessDetailsRouteArgs> {
  BusinessDetailsRoute({
    _i11.Key? key,
    required String id,
    List<_i10.PageRouteInfo>? children,
  }) : super(
         BusinessDetailsRoute.name,
         args: BusinessDetailsRouteArgs(key: key, id: id),
         initialChildren: children,
       );

  static const String name = 'BusinessDetailsRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<BusinessDetailsRouteArgs>();
      return _i2.BusinessDetailsScreen(key: args.key, id: args.id);
    },
  );
}

class BusinessDetailsRouteArgs {
  const BusinessDetailsRouteArgs({this.key, required this.id});

  final _i11.Key? key;

  final String id;

  @override
  String toString() {
    return 'BusinessDetailsRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i3.FavoritesScreen]
class FavoritesRoute extends _i10.PageRouteInfo<void> {
  const FavoritesRoute({List<_i10.PageRouteInfo>? children})
    : super(FavoritesRoute.name, initialChildren: children);

  static const String name = 'FavoritesRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i3.FavoritesScreen();
    },
  );
}

/// generated route for
/// [_i4.FeedScreen]
class FeedRoute extends _i10.PageRouteInfo<void> {
  const FeedRoute({List<_i10.PageRouteInfo>? children})
    : super(FeedRoute.name, initialChildren: children);

  static const String name = 'FeedRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i4.FeedScreen();
    },
  );
}

/// generated route for
/// [_i5.PlacesShowcaseScreen]
class PlacesShowcaseRoute extends _i10.PageRouteInfo<void> {
  const PlacesShowcaseRoute({List<_i10.PageRouteInfo>? children})
    : super(PlacesShowcaseRoute.name, initialChildren: children);

  static const String name = 'PlacesShowcaseRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i5.PlacesShowcaseScreen();
    },
  );
}

/// generated route for
/// [_i6.ProfileScreen]
class ProfileRoute extends _i10.PageRouteInfo<void> {
  const ProfileRoute({List<_i10.PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i6.ProfileScreen();
    },
  );
}

/// generated route for
/// [_i7.SignInScreen]
class SignInRoute extends _i10.PageRouteInfo<SignInRouteArgs> {
  SignInRoute({_i11.Key? key, List<_i10.PageRouteInfo>? children})
    : super(
        SignInRoute.name,
        args: SignInRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'SignInRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SignInRouteArgs>(
        orElse: () => const SignInRouteArgs(),
      );
      return _i7.SignInScreen(key: args.key);
    },
  );
}

class SignInRouteArgs {
  const SignInRouteArgs({this.key});

  final _i11.Key? key;

  @override
  String toString() {
    return 'SignInRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i8.SignUpScreen]
class SignUpRoute extends _i10.PageRouteInfo<SignUpRouteArgs> {
  SignUpRoute({_i11.Key? key, List<_i10.PageRouteInfo>? children})
    : super(
        SignUpRoute.name,
        args: SignUpRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'SignUpRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SignUpRouteArgs>(
        orElse: () => const SignUpRouteArgs(),
      );
      return _i8.SignUpScreen(key: args.key);
    },
  );
}

class SignUpRouteArgs {
  const SignUpRouteArgs({this.key});

  final _i11.Key? key;

  @override
  String toString() {
    return 'SignUpRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i9.SplashScreen]
class SplashRoute extends _i10.PageRouteInfo<void> {
  const SplashRoute({List<_i10.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i9.SplashScreen();
    },
  );
}
