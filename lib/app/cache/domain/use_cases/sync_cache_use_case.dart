import 'dart:async';
import 'package:turbo/app/cache/core/cache_manager.dart';
import 'package:turbo/app/cache/data/repositories/categories_cache_repository.dart';
import 'package:turbo/app/cache/data/repositories/places_cache_repository.dart';
import 'package:turbo/app/cache/data/repositories/events_cache_repository.dart';
import 'package:turbo/app/cache/data/repositories/favorites_cache_repository.dart';
import 'package:turbo/app/core/no_params.dart';
import 'package:turbo/app/core/use_case.dart';

/// Caso de uso para sincronizar todos los caches durante el splash screen
class SyncCacheUseCase implements UseCase<Future<void>, NoParams> {
  final CacheManager _cacheManager;
  final CategoriesCacheRepository _categoriesRepository;
  final PlacesCacheRepository _placesRepository;
  final EventsCacheRepository _eventsRepository;
  final FavoritesCacheRepository _favoritesRepository;

  SyncCacheUseCase({
    required CacheManager cacheManager,
    required CategoriesCacheRepository categoriesRepository,
    required PlacesCacheRepository placesRepository,
    required EventsCacheRepository eventsRepository,
    required FavoritesCacheRepository favoritesRepository,
  }) : _cacheManager = cacheManager,
       _categoriesRepository = categoriesRepository,
       _placesRepository = placesRepository,
       _eventsRepository = eventsRepository,
       _favoritesRepository = favoritesRepository;

  @override
  Future<void> call(NoParams params) async {
    // Sincronizar todos los repositorios de cache
    await Future.wait([
      _categoriesRepository.syncCategories(),
      _placesRepository.syncPlaces(),
      _eventsRepository.syncEvents(),
      // Note: No sincronizamos favoritos aquí ya que requieren userId
    ]);
  }

  /// Stream de progreso de sincronización para UI reactiva
  Stream<SyncProgress> getSyncProgress() async* {
    yield SyncProgress(message: 'Iniciando sincronización...', progress: 0.0);

    try {
      // 1. Sincronizar categorías (25%)
      yield SyncProgress(message: 'Sincronizando categorías...', progress: 0.1);
      await _categoriesRepository.syncCategories();
      yield SyncProgress(message: 'Categorías sincronizadas', progress: 0.25);

      // 2. Sincronizar lugares (50%)
      yield SyncProgress(message: 'Sincronizando lugares...', progress: 0.3);
      await _placesRepository.syncPlaces();
      yield SyncProgress(message: 'Lugares sincronizados', progress: 0.5);

      // 3. Sincronizar eventos (75%)
      yield SyncProgress(message: 'Sincronizando eventos...', progress: 0.6);
      await _eventsRepository.syncEvents();
      yield SyncProgress(message: 'Eventos sincronizados', progress: 0.75);

      // 4. Pre-cargar eventos de hoy (90%)
      yield SyncProgress(
        message: 'Cargando eventos destacados...',
        progress: 0.8,
      );
      await _eventsRepository.preloadEvents();
      yield SyncProgress(message: 'Todo listo!', progress: 1.0);
    } catch (e) {
      yield SyncProgress(
        message: 'Error durante sincronización: $e',
        progress: 0.0,
        hasError: true,
      );
    }
  }

  /// Sincronizar favoritos para un usuario específico
  Future<void> syncUserFavorites(String userId) async {
    try {
      await _favoritesRepository.syncFavorites(userId);
    } catch (e) {
      print('SyncCacheUseCase: Error sincronizando favoritos - $e');
    }
  }
}

/// Clase para representar el progreso de sincronización
class SyncProgress {
  final String message;
  final double progress; // 0.0 a 1.0
  final bool hasError;

  SyncProgress({
    required this.message,
    required this.progress,
    this.hasError = false,
  });
}
