import 'package:turbo/app/cache/core/cache_manager.dart';
import 'package:turbo/app/cache/core/cache_strategy.dart';
import 'package:core/core.dart';

/// Repositorio de cache para categorías
class CategoriesCacheRepository {
  final CacheManager _cacheManager;
  final CategoryRepository _networkRepository;

  CategoriesCacheRepository({
    required CacheManager cacheManager,
    required CategoryRepository networkRepository,
  }) : _cacheManager = cacheManager,
       _networkRepository = networkRepository;

  /// Obtiene todas las categorías usando cache
  Future<CacheResult<List<Category>>> getCategories() async {
    return await _cacheManager.getMultipleData<Category>(
      type: 'categories',
      config: CacheConfig.categories,
      networkCall: () => _networkRepository.getAllCategories(),
      fromJson: (json) => Category.fromJson(json),
      toJson: (category) => category.toJson(),
    );
  }

  /// Obtiene una categoría por ID usando cache
  Future<CacheResult<Category?>> getCategoryById(String categoryId) async {
    return await _cacheManager.getData<Category?>(
      type: 'categories',
      id: categoryId,
      config: CacheConfig.categories,
      networkCall: () => _networkRepository.getCategoryById(categoryId),
      fromJson: (json) => Category.fromJson(json),
      toJson: (category) => category?.toJson() ?? {},
    );
  }

  /// Obtiene lugares de una categoría usando cache
  Future<CacheResult<List<Place>>> getPlacesByCategory(
    String categoryId,
  ) async {
    return await _cacheManager.getMultipleData<Place>(
      type: 'places_by_category_$categoryId',
      config: CacheConfig.places,
      networkCall: () => _networkRepository.getPlacesByCategory(categoryId),
      fromJson: (json) => Place.fromJson(json),
      toJson: (place) => place.toJson(),
    );
  }

  /// Sincroniza todas las categorías
  Future<void> syncCategories() async {
    try {
      final categories = await _networkRepository.getAllCategories();

      // Guardar en cache usando el cache manager
      await _cacheManager.getMultipleData<Category>(
        type: 'categories',
        config: CacheConfig.categories,
        networkCall: () async => categories,
        fromJson: (json) => Category.fromJson(json),
        toJson: (category) => category.toJson(),
      );
    } catch (e) {
      throw Exception('Error al sincronizar categorías: $e');
    }
  }

  /// Verifica si hay datos de categorías en cache
  Future<bool> hasCachedCategories() async {
    final cacheInfo = await _cacheManager.getCacheInfo('categories');
    return cacheInfo.validItems > 0;
  }

  /// Limpia el cache de categorías
  Future<void> clearCategoriesCache() async {
    await _cacheManager.clearCache('categories');
  }

  /// Obtiene información del cache de categorías
  Future<CacheInfo> getCacheInfo() async {
    return await _cacheManager.getCacheInfo('categories');
  }
}
