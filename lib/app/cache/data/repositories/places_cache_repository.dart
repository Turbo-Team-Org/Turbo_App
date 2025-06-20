import 'package:core/core.dart';
import 'package:turbo/app/cache/core/cache_manager.dart';
import 'package:turbo/app/cache/core/cache_strategy.dart';

/// Repository de cache para Places con estrategia Cache-First
/// Datos críticos que necesitan estar disponibles offline
class PlacesCacheRepository {
  final CacheManager _cacheManager;
  final PlaceRepository _networkRepository;

  PlacesCacheRepository({
    required CacheManager cacheManager,
    required PlaceRepository networkRepository,
  }) : _cacheManager = cacheManager,
       _networkRepository = networkRepository;

  /// Obtiene todos los lugares usando cache
  Future<CacheResult<List<Place>>> getPlaces() async {
    return await _cacheManager.getMultipleData<Place>(
      type: 'places',
      config: CacheConfig.places,
      networkCall: () => _networkRepository.getPlaces(),
      fromJson: (json) => Place.fromJson(json),
      toJson: (place) => place.toJson(),
    );
  }

  /// Pre-carga lugares más populares para mejor rendimiento
  Future<void> preloadPopularPlaces() async {
    try {
      await getPlaces();
      print('Places Cache: Pre-carga de lugares populares completada');
    } catch (e) {
      print('Places Cache: Error en pre-carga - $e');
    }
  }

  /// Sincroniza lugares en background
  Future<void> syncPlaces() async {
    try {
      await getPlaces();
      print('Places Cache: Sincronización completada');
    } catch (e) {
      print('Places Cache: Error en sincronización - $e');
    }
  }

  /// Limpia cache de lugares
  Future<void> clearPlacesCache() async {
    try {
      await _cacheManager.clearCache('places');
      print('Places Cache: Cache limpiado');
    } catch (e) {
      print('Places Cache: Error limpiando cache - $e');
    }
  }

  /// Obtiene estadísticas del cache de lugares
  Future<CacheInfo> getCacheStats() async {
    try {
      return await _cacheManager.getCacheInfo('places');
    } catch (e) {
      print('Places Cache: Error obteniendo estadísticas - $e');
      // Retornar estadísticas vacías en caso de error
      return CacheInfo(
        type: 'places',
        totalItems: 0,
        validItems: 0,
        expiredItems: 0,
        lastSyncAt: DateTime.now(),
        sizeInBytes: 0,
      );
    }
  }

  /// Verifica si hay datos en cache
  Future<bool> hasCachedPlaces() async {
    try {
      final stats = await getCacheStats();
      return stats.totalItems > 0;
    } catch (e) {
      return false;
    }
  }
}
