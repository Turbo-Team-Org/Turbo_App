// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i18;
import 'package:core/core.dart' as _i20;
import 'package:flutter/material.dart' as _i19;
import 'package:turbo/app/presentation/screens/turbo_splash_screen.dart'
    as _i17;
import 'package:turbo/app/view/widgets/bottom_nav_shield.dart' as _i3;
import 'package:turbo/authentication/presentation/screens/sign_in_screen.dart'
    as _i14;
import 'package:turbo/authentication/presentation/screens/sign_up_screen.dart'
    as _i15;
import 'package:turbo/authentication/presentation/screens/splash_screen.dart'
    as _i16;
import 'package:turbo/categories/presentation/screens/categories_screen.dart'
    as _i5;
import 'package:turbo/categories/presentation/screens/category_details_screen.dart'
    as _i6;
import 'package:turbo/events/presentation/screens/events_screen.dart' as _i7;
import 'package:turbo/favorites/presentation/screens/favorite_screen.dart'
    as _i8;
import 'package:turbo/places/presentation/screens/business_detail.dart' as _i4;
import 'package:turbo/places/presentation/screens/feed_screen.dart' as _i9;
import 'package:turbo/places/presentation/screens/places_showcase_screen.dart'
    as _i11;
import 'package:turbo/reservations/presentation/screens/booking_form_page.dart'
    as _i1;
import 'package:turbo/reservations/presentation/screens/booking_page.dart'
    as _i2;
import 'package:turbo/reservations/presentation/screens/my_reservations_page.dart'
    as _i10;
import 'package:turbo/reservations/presentation/screens/reservation_details_page.dart'
    as _i13;
import 'package:turbo/users/presentation/screens/profile_screen.dart' as _i12;

/// generated route for
/// [_i1.BookingFormPage]
class BookingFormRoute extends _i18.PageRouteInfo<BookingFormRouteArgs> {
  BookingFormRoute({
    _i19.Key? key,
    required String placeId,
    required String placeName,
    required DateTime selectedDate,
    required _i20.ReservationTimeSlot selectedSlot,
    List<_i18.PageRouteInfo>? children,
  }) : super(
         BookingFormRoute.name,
         args: BookingFormRouteArgs(
           key: key,
           placeId: placeId,
           placeName: placeName,
           selectedDate: selectedDate,
           selectedSlot: selectedSlot,
         ),
         initialChildren: children,
       );

  static const String name = 'BookingFormRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<BookingFormRouteArgs>();
      return _i1.BookingFormPage(
        key: args.key,
        placeId: args.placeId,
        placeName: args.placeName,
        selectedDate: args.selectedDate,
        selectedSlot: args.selectedSlot,
      );
    },
  );
}

class BookingFormRouteArgs {
  const BookingFormRouteArgs({
    this.key,
    required this.placeId,
    required this.placeName,
    required this.selectedDate,
    required this.selectedSlot,
  });

  final _i19.Key? key;

  final String placeId;

  final String placeName;

  final DateTime selectedDate;

  final _i20.ReservationTimeSlot selectedSlot;

  @override
  String toString() {
    return 'BookingFormRouteArgs{key: $key, placeId: $placeId, placeName: $placeName, selectedDate: $selectedDate, selectedSlot: $selectedSlot}';
  }
}

/// generated route for
/// [_i2.BookingPage]
class BookingRoute extends _i18.PageRouteInfo<BookingRouteArgs> {
  BookingRoute({
    _i19.Key? key,
    required String placeId,
    required String placeName,
    String? placeImage,
    List<_i18.PageRouteInfo>? children,
  }) : super(
         BookingRoute.name,
         args: BookingRouteArgs(
           key: key,
           placeId: placeId,
           placeName: placeName,
           placeImage: placeImage,
         ),
         initialChildren: children,
       );

  static const String name = 'BookingRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<BookingRouteArgs>();
      return _i2.BookingPage(
        key: args.key,
        placeId: args.placeId,
        placeName: args.placeName,
        placeImage: args.placeImage,
      );
    },
  );
}

class BookingRouteArgs {
  const BookingRouteArgs({
    this.key,
    required this.placeId,
    required this.placeName,
    this.placeImage,
  });

  final _i19.Key? key;

  final String placeId;

  final String placeName;

  final String? placeImage;

  @override
  String toString() {
    return 'BookingRouteArgs{key: $key, placeId: $placeId, placeName: $placeName, placeImage: $placeImage}';
  }
}

/// generated route for
/// [_i3.BottomNavShellWidget]
class BottomNavShellWidget extends _i18.PageRouteInfo<void> {
  const BottomNavShellWidget({List<_i18.PageRouteInfo>? children})
    : super(BottomNavShellWidget.name, initialChildren: children);

  static const String name = 'BottomNavShellWidget';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i3.BottomNavShellWidget();
    },
  );
}

/// generated route for
/// [_i4.BusinessDetailsScreen]
class BusinessDetailsRoute
    extends _i18.PageRouteInfo<BusinessDetailsRouteArgs> {
  BusinessDetailsRoute({
    _i19.Key? key,
    required String id,
    List<_i18.PageRouteInfo>? children,
  }) : super(
         BusinessDetailsRoute.name,
         args: BusinessDetailsRouteArgs(key: key, id: id),
         initialChildren: children,
       );

  static const String name = 'BusinessDetailsRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<BusinessDetailsRouteArgs>();
      return _i4.BusinessDetailsScreen(key: args.key, id: args.id);
    },
  );
}

class BusinessDetailsRouteArgs {
  const BusinessDetailsRouteArgs({this.key, required this.id});

  final _i19.Key? key;

  final String id;

  @override
  String toString() {
    return 'BusinessDetailsRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i5.CategoriesScreen]
class CategoriesRoute extends _i18.PageRouteInfo<void> {
  const CategoriesRoute({List<_i18.PageRouteInfo>? children})
    : super(CategoriesRoute.name, initialChildren: children);

  static const String name = 'CategoriesRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i5.CategoriesScreen();
    },
  );
}

/// generated route for
/// [_i6.CategoryDetailsScreen]
class CategoryDetailsRoute
    extends _i18.PageRouteInfo<CategoryDetailsRouteArgs> {
  CategoryDetailsRoute({
    _i19.Key? key,
    required _i20.Category category,
    List<_i18.PageRouteInfo>? children,
  }) : super(
         CategoryDetailsRoute.name,
         args: CategoryDetailsRouteArgs(key: key, category: category),
         initialChildren: children,
       );

  static const String name = 'CategoryDetailsRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CategoryDetailsRouteArgs>();
      return _i6.CategoryDetailsScreen(key: args.key, category: args.category);
    },
  );
}

class CategoryDetailsRouteArgs {
  const CategoryDetailsRouteArgs({this.key, required this.category});

  final _i19.Key? key;

  final _i20.Category category;

  @override
  String toString() {
    return 'CategoryDetailsRouteArgs{key: $key, category: $category}';
  }
}

/// generated route for
/// [_i7.EventsScreen]
class EventsRoute extends _i18.PageRouteInfo<void> {
  const EventsRoute({List<_i18.PageRouteInfo>? children})
    : super(EventsRoute.name, initialChildren: children);

  static const String name = 'EventsRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i7.EventsScreen();
    },
  );
}

/// generated route for
/// [_i8.FavoritesScreen]
class FavoritesRoute extends _i18.PageRouteInfo<void> {
  const FavoritesRoute({List<_i18.PageRouteInfo>? children})
    : super(FavoritesRoute.name, initialChildren: children);

  static const String name = 'FavoritesRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i8.FavoritesScreen();
    },
  );
}

/// generated route for
/// [_i9.FeedScreen]
class FeedRoute extends _i18.PageRouteInfo<void> {
  const FeedRoute({List<_i18.PageRouteInfo>? children})
    : super(FeedRoute.name, initialChildren: children);

  static const String name = 'FeedRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i9.FeedScreen();
    },
  );
}

/// generated route for
/// [_i10.MyReservationsPage]
class MyReservationsRoute extends _i18.PageRouteInfo<void> {
  const MyReservationsRoute({List<_i18.PageRouteInfo>? children})
    : super(MyReservationsRoute.name, initialChildren: children);

  static const String name = 'MyReservationsRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i10.MyReservationsPage();
    },
  );
}

/// generated route for
/// [_i11.PlacesShowcaseScreen]
class PlacesShowcaseRoute extends _i18.PageRouteInfo<void> {
  const PlacesShowcaseRoute({List<_i18.PageRouteInfo>? children})
    : super(PlacesShowcaseRoute.name, initialChildren: children);

  static const String name = 'PlacesShowcaseRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i11.PlacesShowcaseScreen();
    },
  );
}

/// generated route for
/// [_i12.ProfileScreen]
class ProfileRoute extends _i18.PageRouteInfo<void> {
  const ProfileRoute({List<_i18.PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i12.ProfileScreen();
    },
  );
}

/// generated route for
/// [_i13.ReservationDetailsPage]
class ReservationDetailsRoute
    extends _i18.PageRouteInfo<ReservationDetailsRouteArgs> {
  ReservationDetailsRoute({
    _i19.Key? key,
    required String reservationId,
    _i20.Reservation? reservation,
    List<_i18.PageRouteInfo>? children,
  }) : super(
         ReservationDetailsRoute.name,
         args: ReservationDetailsRouteArgs(
           key: key,
           reservationId: reservationId,
           reservation: reservation,
         ),
         initialChildren: children,
       );

  static const String name = 'ReservationDetailsRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ReservationDetailsRouteArgs>();
      return _i13.ReservationDetailsPage(
        key: args.key,
        reservationId: args.reservationId,
        reservation: args.reservation,
      );
    },
  );
}

class ReservationDetailsRouteArgs {
  const ReservationDetailsRouteArgs({
    this.key,
    required this.reservationId,
    this.reservation,
  });

  final _i19.Key? key;

  final String reservationId;

  final _i20.Reservation? reservation;

  @override
  String toString() {
    return 'ReservationDetailsRouteArgs{key: $key, reservationId: $reservationId, reservation: $reservation}';
  }
}

/// generated route for
/// [_i14.SignInScreen]
class SignInRoute extends _i18.PageRouteInfo<SignInRouteArgs> {
  SignInRoute({_i19.Key? key, List<_i18.PageRouteInfo>? children})
    : super(
        SignInRoute.name,
        args: SignInRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'SignInRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SignInRouteArgs>(
        orElse: () => const SignInRouteArgs(),
      );
      return _i14.SignInScreen(key: args.key);
    },
  );
}

class SignInRouteArgs {
  const SignInRouteArgs({this.key});

  final _i19.Key? key;

  @override
  String toString() {
    return 'SignInRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i15.SignUpScreen]
class SignUpRoute extends _i18.PageRouteInfo<SignUpRouteArgs> {
  SignUpRoute({_i19.Key? key, List<_i18.PageRouteInfo>? children})
    : super(
        SignUpRoute.name,
        args: SignUpRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'SignUpRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SignUpRouteArgs>(
        orElse: () => const SignUpRouteArgs(),
      );
      return _i15.SignUpScreen(key: args.key);
    },
  );
}

class SignUpRouteArgs {
  const SignUpRouteArgs({this.key});

  final _i19.Key? key;

  @override
  String toString() {
    return 'SignUpRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i16.SplashScreen]
class SplashRoute extends _i18.PageRouteInfo<void> {
  const SplashRoute({List<_i18.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i16.SplashScreen();
    },
  );
}

/// generated route for
/// [_i17.TurboSplashScreen]
class TurboSplashRoute extends _i18.PageRouteInfo<void> {
  const TurboSplashRoute({List<_i18.PageRouteInfo>? children})
    : super(TurboSplashRoute.name, initialChildren: children);

  static const String name = 'TurboSplashRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i17.TurboSplashScreen();
    },
  );
}
