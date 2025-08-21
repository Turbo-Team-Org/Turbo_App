import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:turbo/app/image_management/data/repositories/image_management_repository_impl.dart';
import 'package:turbo/app/image_management/domain/repositories/image_management_repository.dart';
import 'package:turbo/app/image_management/presentation/cubit/image_management_cubit.dart';
import 'package:turbo/app/notification/service/notification_service.dart';
import 'package:turbo/authentication/module/authentication_module.dart';
import 'package:turbo/authentication/module/sign_in_with_email_use_case.dart';
import 'package:turbo/authentication/module/sign_out_use_case.dart';
import 'package:turbo/authentication/module/sign_up_with_email_use_case.dart';
import 'package:turbo/authentication/state_management/auth_cubit/cubit/auth_cubit_cubit.dart';
import 'package:turbo/authentication/state_management/sign_out_cubit/cubit/sign_out_cubit.dart';
import 'package:turbo/authentication/state_management/sign_up_cubit/cubit/sign_up_cubit.dart';
import 'package:turbo/categories/module/get_categories_use_case.dart';
import 'package:turbo/categories/module/get_category_by_id_use_case.dart';
import 'package:turbo/categories/module/get_places_by_category_use_case.dart';
import 'package:turbo/categories/state_management/category_cubit.dart';
import 'package:turbo/events/module/get_events_use_case.dart';
import 'package:turbo/events/module/get_today_events_use_case.dart';
import 'package:turbo/events/state_management/event_bloc/cubit/event_cubit.dart';
import 'package:turbo/favorites/module/toogle_favorite_use_case.dart';
import 'package:turbo/firebase_options.dart';
import 'package:turbo/location/module/get_current_location_use_case.dart';
import 'package:turbo/location/module/request_location_permission_use_case.dart';
import 'package:turbo/location/state_management/location_bloc/cubit/location_cubit.dart';
import 'package:turbo/places/module/get_places_use_case.dart';
import 'package:turbo/places/state_management/place_bloc/cubit/place_cubit.dart';
import 'package:turbo/places/state_management/place_search_cubit/places_search_cubit.dart';
import '../../authentication/module/sign_with_google_use_case.dart';
import '../../authentication/state_management/sign_in_cubit/cubit/sign_in_cubit.dart';
import '../../favorites/module/get_favorites_use_case.dart';
import '../../favorites/state_management/cubit/favorite_cubit.dart';
import '../../reviews/module/add_review_use_case.dart';
import '../../reviews/module/get_all_reviews_use_case.dart';
import '../../reviews/module/get_reviews_from_a_place_use_case.dart';
import '../../reviews/state_management/cubit/review_cubit.dart';
import '../utils/app_preferences.dart';
import 'package:turbo/app/core/theme/theme_cubit.dart';
import 'package:core/src/core.dart';
import 'package:turbo/app/cache/core/cache_manager.dart';
import 'package:turbo/app/cache/data/repositories/categories_cache_repository.dart';
import 'package:turbo/app/cache/domain/use_cases/sync_cache_use_case.dart';
import 'package:turbo/app/cache/presentation/cubit/sync_cubit.dart';
import 'package:turbo/app/cache/data/repositories/places_cache_repository.dart';
import 'package:turbo/app/cache/data/repositories/events_cache_repository.dart';
import 'package:turbo/app/cache/data/repositories/favorites_cache_repository.dart';
import 'package:turbo/reservations/module/reservations_module.dart';
import 'package:turbo/places/module/search_places_use_case.dart';
import 'package:turbo/places/module/get_places_by_location_use_case.dart';
import 'package:turbo/places/module/search_nearby_places_use_case.dart';

///The init order of dependencies is Service/ Repository/ Use Cases (Module)/ State Managament(Cubit or Bloc)

FutureOr<void> initDependencies(GetIt sl) async {
  await AppPreferences.init();
  //final db = DatabaseHelper();
  final firebaseInstance = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  ///Initializing core package
  /// Determining environment
  final environment =
      kDebugMode ? TurboEnvironment.staging : TurboEnvironment.dev;
  await initCoreDependencies(
    enableDebugLogs: true,
    // firebaseApp: firebaseInstance,
    sl: sl,
    environment: environment,
  );

  ///Initializing cache system
  final cacheManager = CacheManager();
  await cacheManager.initialize();
  sl.registerSingleton<CacheManager>(cacheManager);

  sl
    ..registerLazySingleton<NotificationService>(
      () => NotificationService(firestore: sl<FirebaseFirestore>()),
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
    ..registerLazySingleton<GetPlacesUseCase>(
      () => GetPlacesUseCase(placeRepository: sl<PlaceRepository>()),
    )
    // Nuevos casos de uso de búsqueda
    ..registerLazySingleton<SearchPlacesUseCase>(
      () => SearchPlacesUseCase(
        placeRepository: sl<PlaceRepository>(),
        // locationRepository: sl<LocationRepository>(),
      ),
    )
    ..registerLazySingleton<GetPlacesByLocationUseCase>(
      () => GetPlacesByLocationUseCase(
        locationRepository: sl<LocationRepository>(),
        placeRepository: sl<PlaceRepository>(),
      ),
    )
    ..registerLazySingleton<SearchNearbyPlacesUseCase>(
      () => SearchNearbyPlacesUseCase(
        locationRepository: sl<LocationRepository>(),
        placeRepository: sl<PlaceRepository>(),
      ),
    )
    ..registerLazySingleton<SearchPlacesByVoiceUseCase>(
      () => SearchPlacesByVoiceUseCase(placeRepository: sl<PlaceRepository>()),
    )
    // Actualizar GetPlacesByCategoryUseCase para incluir LocationRepository
    ..registerLazySingleton<GetPlacesByCategoryUseCase>(
      () => GetPlacesByCategoryUseCase(
        placeCategoryRepository: sl<PlaceCategoryRepository>(),
        locationRepository: sl<LocationRepository>(),
      ),
    )
    ..registerLazySingleton<PlaceCubit>(
      () => PlaceCubit(
        getPlacesUseCase: sl<GetPlacesUseCase>(),
        getPlacesByCategoryUseCase: sl<GetPlacesByCategoryUseCase>(),
      ),
    )
    // Actualizar PlacesSearchCubit con todos los casos de uso
    ..registerFactory<PlacesSearchCubit>(
      () => PlacesSearchCubit(
        searchPlacesByVoiceUseCase: sl<SearchPlacesByVoiceUseCase>(),
        getPlacesByCategoryUseCase: sl<GetPlacesByCategoryUseCase>(),
        searchPlacesUseCase: sl<SearchPlacesUseCase>(),
        getPlacesByLocationUseCase: sl<GetPlacesByLocationUseCase>(),
        searchNearbyPlacesUseCase: sl<SearchNearbyPlacesUseCase>(),
      ),
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
    ..registerLazySingleton<GetCurrentLocationUseCase>(
      () => GetCurrentLocationUseCase(sl<LocationRepository>()),
    )
    ..registerLazySingleton<RequestLocationPermissionUseCase>(
      () => RequestLocationPermissionUseCase(),
    )
    ..registerLazySingleton<LocationCubit>(
      () => LocationCubit(
        getCurrentLocationUseCase: sl<GetCurrentLocationUseCase>(),
        requestLocationPermissionUseCase:
            sl<RequestLocationPermissionUseCase>(),
      ),
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
    ..registerLazySingleton<GetCategoriesUseCase>(
      () => GetCategoriesUseCase(repository: sl<CategoryRepository>()),
    )
    ..registerLazySingleton<GetCategoryByIdUseCase>(
      () => GetCategoryByIdUseCase(repository: sl<CategoryRepository>()),
    )
    ..registerLazySingleton<CategoryCubit>(
      () => CategoryCubit(
        getCategoriesUseCase: sl<GetCategoriesUseCase>(),
        getCategoryByIdUseCase: sl<GetCategoryByIdUseCase>(),
        getPlacesByCategoryUseCase: sl<GetPlacesByCategoryUseCase>(),
      ),
    )
    ..registerLazySingleton<CategoriesCacheRepository>(
      () => CategoriesCacheRepository(
        cacheManager: sl<CacheManager>(),
        networkRepository: sl<CategoryRepository>(),
      ),
    )
    ..registerLazySingleton<PlacesCacheRepository>(
      () => PlacesCacheRepository(
        cacheManager: sl<CacheManager>(),
        networkRepository: sl<PlaceRepository>(),
      ),
    )
    ..registerLazySingleton<EventsCacheRepository>(
      () => EventsCacheRepository(
        cacheManager: sl<CacheManager>(),
        networkRepository: sl<EventRepository>(),
      ),
    )
    ..registerLazySingleton<FavoritesCacheRepository>(
      () => FavoritesCacheRepository(
        cacheManager: sl<CacheManager>(),
        networkRepository: sl<FavoriteRepository>(),
      ),
    )
    ..registerLazySingleton<SyncCacheUseCase>(
      () => SyncCacheUseCase(
        cacheManager: sl<CacheManager>(),
        categoriesRepository: sl<CategoriesCacheRepository>(),
        placesRepository: sl<PlacesCacheRepository>(),
        eventsRepository: sl<EventsCacheRepository>(),
        favoritesRepository: sl<FavoritesCacheRepository>(),
      ),
    )
    ..registerLazySingleton<SyncCubit>(
      () => SyncCubit(syncCacheUseCase: sl<SyncCacheUseCase>()),
    )
    ..registerLazySingleton<ImageManagementRepository>(
      () => ImageManagementRepositoryImpl(),
    )
    ..registerLazySingleton(
      () => ImageManagementCubit(repository: sl<ImageManagementRepository>()),
    );

  ///Initializing reservations module
  ReservationsModule.setup();
}
