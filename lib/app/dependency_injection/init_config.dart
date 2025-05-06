import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:turbo/app/notification/service/notification_service.dart';
import 'package:turbo/authentication/module/authentication_module.dart';
import 'package:turbo/authentication/module/sign_in_with_email_use_case.dart';
import 'package:turbo/authentication/module/sign_out_use_case.dart';
import 'package:turbo/authentication/module/sign_up_with_email_use_case.dart';
import 'package:turbo/authentication/state_managament/auth_cubit/cubit/auth_cubit_cubit.dart';
import 'package:turbo/authentication/state_managament/sign_out_cubit/cubit/sign_out_cubit.dart';
import 'package:turbo/authentication/state_managament/sign_up_cubit/cubit/sign_up_cubit.dart';
import 'package:turbo/categories/category_repository/category_repository.dart';
import 'package:turbo/categories/category_repository/service/category_service.dart';
import 'package:turbo/categories/module/get_categories_use_case.dart';
import 'package:turbo/categories/module/get_category_by_id_use_case.dart';
import 'package:turbo/categories/module/get_places_by_category_use_case.dart';
import 'package:turbo/categories/module/place_category_association.dart';
import 'package:turbo/categories/module/update_place_categories_use_case.dart';
import 'package:turbo/categories/state_management/category_bloc/category_cubit/cubit/category_cubit.dart';
import 'package:turbo/events/event_repository/event_repository.dart';
import 'package:turbo/events/event_repository/service/event_service.dart';
import 'package:turbo/events/module/get_events_use_case.dart';
import 'package:turbo/events/module/get_today_events_use_case.dart';
import 'package:turbo/events/state_management/event_bloc/cubit/event_cubit.dart';
import 'package:turbo/favorites/module/toogle_favorite_use_case.dart';
import 'package:turbo/firebase_options.dart';
import 'package:turbo/location/location_repository/location_repository.dart';
import 'package:turbo/location/location_repository/service/location_service.dart';
import 'package:turbo/location/module/get_current_location_use_case.dart';
import 'package:turbo/location/module/request_location_permission_use_case.dart';
import 'package:turbo/location/state_management/location_bloc/cubit/location_cubit.dart';
import 'package:turbo/places/module/get_places_use_case.dart';
import 'package:turbo/places/place_repository/place_repository.dart';
import 'package:turbo/places/place_repository/service/place_service.dart';
import 'package:turbo/places/state_management/place_bloc/cubit/place_cubit.dart';

import '../../authentication/authentication_repository/authentication_repository.dart';
import '../../authentication/authentication_repository/service/authentication_service.dart';
import '../../authentication/module/sign_with_google_use_case.dart';
import '../../authentication/state_managament/sign_in_cubit/cubit/sign_in_cubit.dart';
import '../../favorites/favorite_repository/favorite_repository.dart';
import '../../favorites/favorite_repository/service/favorite_service.dart';
import '../../favorites/module/get_favorites_use_case.dart';
import '../../favorites/state_management/cubit/favorite_cubit.dart';
import '../../reviews/module/add_review_use_case.dart';
import '../../reviews/module/get_all_reviews_use_case.dart';
import '../../reviews/module/get_reviews_from_a_place_use_case.dart';
import '../../reviews/review_repository/review_repository.dart';
import '../../reviews/review_repository/service/review_service.dart';
import '../../reviews/state_management/cubit/review_cubit.dart';
import '../utils/app_preferences.dart';
import 'package:turbo/app/core/theme/theme_cubit.dart';

///The init order of dependencies is Service/ Repository/ Use Cases (Module)/ State Managament(Cubit or Bloc)

FutureOr<void> initCore(GetIt sl) async {
  await AppPreferences.init();
  //final db = DatabaseHelper();
  final firebaseInstance = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  sl
    ..registerSingleton<FirebaseFirestore>(
      FirebaseFirestore.instanceFor(app: firebaseInstance),
    )
    ..registerSingleton<FirebaseAuth>(
      FirebaseAuth.instanceFor(app: firebaseInstance),
    )
    ..registerLazySingleton<NotificationService>(
      () => NotificationService(firestore: sl<FirebaseFirestore>()),
    )
    ..registerLazySingleton<AuthenticationService>(
      () => AuthenticationService(
        firebaseAuth: sl<FirebaseAuth>(),
        firestore: sl<FirebaseFirestore>(),
      ),
    )
    ..registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepository(authService: sl<AuthenticationService>()),
    )
    ..registerLazySingleton<SignInWithGoogleUseCase>(
      () => SignInWithGoogleUseCase(
        authenticationRepository: sl<AuthenticationRepository>(),
      ),
    )
    ..registerLazySingleton<SignInWithEmailUseCase>(
      () => SignInWithEmailUseCase(
        authenticationRepository: sl<AuthenticationRepository>(),
      ),
    )
    ..registerLazySingleton<SignUpWithEmailUseCase>(
      () => SignUpWithEmailUseCase(
        authenticationRepository: sl<AuthenticationRepository>(),
      ),
    )
    ..registerLazySingleton<AuthenticationModule>(
      () => AuthenticationModule(
        authenticationRepository: sl<AuthenticationRepository>(),
      ),
    )
    ..registerLazySingleton<SignOutUseCase>(
      () => SignOutUseCase(
        authenticationRepository: sl<AuthenticationRepository>(),
      ),
    )
    ..registerLazySingleton<SignInCubit>(
      () => SignInCubit(
        signInWithEmailUseCase: sl<SignInWithEmailUseCase>(),
        signInWithGoogleUseCase: sl<SignInWithGoogleUseCase>(),
      ),
    )
    ..registerLazySingleton<AuthCubit>(
      () => AuthCubit(
        authenticationModule: sl<AuthenticationModule>(),
        notificationService: sl<NotificationService>(),
      ),
    )
    ..registerLazySingleton<SignUpCubit>(
      () => SignUpCubit(signUpWithEmailUseCase: sl<SignUpWithEmailUseCase>()),
    )
    ..registerLazySingleton<SignOutCubit>(
      () => SignOutCubit(signOutUseCase: sl<SignOutUseCase>()),
    )
    ..registerLazySingleton<PlaceService>(
      () => PlaceService(firestore: sl<FirebaseFirestore>()),
    )
    ..registerLazySingleton<PlaceRepository>(
      () => PlaceRepository(placeService: sl<PlaceService>()),
    )
    ..registerLazySingleton<GetPlacesUseCase>(
      () => GetPlacesUseCase(placeRepository: sl<PlaceRepository>()),
    )
    ..registerLazySingleton<PlaceCubit>(
      () => PlaceCubit(
        getPlacesUseCase: sl<GetPlacesUseCase>(),
        getPlacesByCategoryUseCase: sl<GetPlacesByCategoryUseCase>(),
      ),
    )
    ..registerLazySingleton<ReviewService>(
      () => ReviewService(firestore: sl<FirebaseFirestore>()),
    )
    ..registerLazySingleton<ReviewRepository>(
      () => ReviewRepository(reviewService: sl<ReviewService>()),
    )
    ..registerLazySingleton<GetAllReviewsUseCase>(
      () => GetAllReviewsUseCase(reviewRepository: sl<ReviewRepository>()),
    )
    ..registerLazySingleton<GetReviewsFromAPlaceUseCase>(
      () =>
          GetReviewsFromAPlaceUseCase(reviewRepository: sl<ReviewRepository>()),
    )
    ..registerLazySingleton<AddReviewUseCase>(
      () => AddReviewUseCase(reviewRepository: sl<ReviewRepository>()),
    )
    ..registerLazySingleton<ReviewCubit>(
      () => ReviewCubit(
        addReviewUseCase: sl<AddReviewUseCase>(),
        getAllReviewsUseCase: sl<GetAllReviewsUseCase>(),
        getReviewsFromAPlaceUseCase: sl<GetReviewsFromAPlaceUseCase>(),
      ),
    )
    ..registerLazySingleton<FavoriteService>(
      () => FavoriteService(firestore: sl<FirebaseFirestore>()),
    )
    ..registerLazySingleton<FavoriteRepository>(
      () => FavoriteRepository(favoriteService: sl<FavoriteService>()),
    )
    ..registerLazySingleton<GetFavoritesUseCase>(
      () => GetFavoritesUseCase(favoriteRepository: sl<FavoriteRepository>()),
    )
    ..registerLazySingleton<ToggleFavoriteUseCase>(
      () => ToggleFavoriteUseCase(favoriteRepository: sl<FavoriteRepository>()),
    )
    ..registerLazySingleton<FavoriteCubit>(
      () => FavoriteCubit(
        getFavoritesUseCase: sl<GetFavoritesUseCase>(),
        toggleFavoriteUseCase: sl<ToggleFavoriteUseCase>(),
      ),
    )
    ..registerLazySingleton(() => ThemeCubit())
    // Registro de dependencias para la geolocalización
    ..registerLazySingleton<LocationService>(() => LocationService())
    ..registerLazySingleton<LocationRepository>(
      () => LocationRepository(locationService: sl<LocationService>()),
    )
    ..registerLazySingleton<GetCurrentLocationUseCase>(
      () => GetCurrentLocationUseCase(sl<LocationRepository>()),
    )
    ..registerLazySingleton<RequestLocationPermissionUseCase>(
      () => RequestLocationPermissionUseCase(sl<LocationRepository>()),
    )
    ..registerLazySingleton<LocationCubit>(
      () => LocationCubit(
        getCurrentLocationUseCase: sl<GetCurrentLocationUseCase>(),
        requestLocationPermissionUseCase:
            sl<RequestLocationPermissionUseCase>(),
      ),
    )
    // Registro de dependencias para eventos
    ..registerLazySingleton<EventService>(
      () => EventService(firestore: sl<FirebaseFirestore>()),
    )
    ..registerLazySingleton<EventRepository>(
      () => EventRepositoryImpl(eventService: sl<EventService>()),
    )
    ..registerLazySingleton<GetEventsUseCase>(
      () => GetEventsUseCase(eventRepository: sl<EventRepository>()),
    )
    ..registerLazySingleton<GetTodayEventsUseCase>(
      () => GetTodayEventsUseCase(eventRepository: sl<EventRepository>()),
    )
    ..registerLazySingleton<EventCubit>(
      () => EventCubit(
        getEventsUseCase: sl<GetEventsUseCase>(),
        getTodayEventsUseCase: sl<GetTodayEventsUseCase>(),
      ),
    )
    // Registro de dependencias para categorías
    ..registerLazySingleton<CategoryService>(
      () => CategoryService(firestore: sl<FirebaseFirestore>()),
    )
    ..registerLazySingleton<CategoryRepository>(
      () => CategoryRepository(categoryService: sl<CategoryService>()),
    )
    ..registerLazySingleton<PlaceCategoryAssociation>(
      () => PlaceCategoryAssociation(firestore: sl<FirebaseFirestore>()),
    )
    ..registerLazySingleton<GetCategoriesUseCase>(
      () => GetCategoriesUseCase(repository: sl<CategoryRepository>()),
    )
    ..registerLazySingleton<GetCategoryByIdUseCase>(
      () => GetCategoryByIdUseCase(repository: sl<CategoryRepository>()),
    )
    ..registerLazySingleton<GetPlacesByCategoryUseCase>(
      () => GetPlacesByCategoryUseCase(
        placeCategoryAssociation: sl<PlaceCategoryAssociation>(),
      ),
    )
    ..registerLazySingleton<UpdatePlaceCategoriesUseCase>(
      () => UpdatePlaceCategoriesUseCase(
        placeCategoryAssociation: sl<PlaceCategoryAssociation>(),
      ),
    )
    ..registerLazySingleton<CategoryCubit>(
      () => CategoryCubit(
        getCategoriesUseCase: sl<GetCategoriesUseCase>(),
        getCategoryByIdUseCase: sl<GetCategoryByIdUseCase>(),
      ),
    );

  // Cargar datos ficticios para desarrollo (descomentar en entorno de desarrollo)
  // sl<EventService>().loadMockDataToFirestore();
}
