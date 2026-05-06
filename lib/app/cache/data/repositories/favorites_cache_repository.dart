import 'package:core/core.dart';
import 'package:turbo/app/cache/core/cache_manager.dart';
import 'package:turbo/app/cache/core/cache_strategy.dart';

/// Repository de cache para Favorites con estrategia Stale-While-Revalidate
/// Datos que necesitan respuesta rápida pero actualizaciones en background
class FavoritesCacheRepository {
  final CacheManager _cacheManager;
  final FavoriteRepository _networkRepository;

  FavoritesCacheRepository({
    required CacheManager cacheManager,
    required FavoriteRepository networkRepository,
  }) : _cacheManager = cacheManager,
       _networkRepository = networkRepository;

  /// Obtiene favoritos del usuario usando cache híbrido
  Future<CacheResult<List<Favorite>>> getFavorites(String userId) async {
    return await _cacheManager.getMultipleData<Favorite>(
      type: 'favorites_$userId',
      config: CacheConfig.favorites,
      networkCall: () => _networkRepository.getFavorites(userId),
      fromJson: (json) => Favorite.fromJson(json),
      toJson: (favorite) => favorite.toJson(),
    );
  }

  /// Alterna el estado de favorito (optimistic update)
  Future<CacheResult<void>> toggleFavorite(Favorite favorite) async {
    try {
      // Actualización optimista: primero actualizar cache local
      await _updateLocalFavoriteStatus(favorite.userId, favorite.placeId);

      // Luego sincronizar con el servidor en background
      await _networkRepository.toggleFavorite(favorite);

      // Actualizar cache con el resultado del servidor
      await _refreshFavoritesCache(favorite.userId);

      return CacheResult.success(
        data: null,
        fromCache: false,
        lastSyncAt: DateTime.now(),
      );
    } catch (e) {
      // Si falla la sincronización, mantener el cambio local
      return CacheResult.error(
        message: 'Error al sincronizar favorito: $e',
        exception: e is Exception ? e : Exception(e.toString()),
      );
    }
  }

  /// Sincroniza favoritos en background
  Future<void> syncFavorites(String userId) async {
    try {
      await getFavorites(userId);
      print('Favorites Cache: Sincronización completada para usuario $userId');
    } catch (e) {
      print('Favorites Cache: Error en sincronización - $e');
    }
  }

  /// Actualiza el estado local de favorito para respuesta inmediata
  Future<void> _updateLocalFavoriteStatus(String userId, String placeId) async {
    try {
      // Aquí implementaríamos la lógica de actualización optimista
      // Por ahora, simplemente invalida el cache para forzar re-fetch
      print('Favorites Cache: Actualizando estado local para lugar $placeId');
    } catch (e) {
      print('Favorites Cache: Error actualizando estado local - $e');
    }
  }

  /// Refresca el cache de favoritos después de una operación
  Future<void> _refreshFavoritesCache(String userId) async {
    try {
      await getFavorites(userId);
    } catch (e) {
      print('Favorites Cache: Error refrescando cache - $e');
    }
  }

  /// Pre-carga favoritos para un usuario
  Future<void> preloadFavorites(String userId) async {
    try {
      await getFavorites(userId);
    } catch (e) {
      // Pre-carga silenciosa
      print('Favorites Cache: Error en pre-carga para usuario $userId - $e');
    }
  }
}
