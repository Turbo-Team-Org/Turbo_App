/// Estrategias de cache disponibles para diferentes tipos de datos
enum CacheStrategy {
  /// Cache primero: busca en cache, si no existe va a network
  /// Ideal para datos críticos que no cambian frecuentemente
  cacheFirst,

  /// Network primero: intenta network, si falla usa cache
  /// Ideal para datos dinámicos que cambian frecuentemente
  networkFirst,

  /// Stale while revalidate: devuelve cache inmediatamente y actualiza en background
  /// Ideal para datos que cambian poco pero queremos mostrar rápido
  staleWhileRevalidate,
}

/// Estados del sistema de cache
enum CacheStatus {
  /// Cache vacío, no hay datos
  empty,

  /// Cargando datos del cache o network
  loading,

  /// Datos cacheados disponibles
  cached,

  /// Sincronizando con el servidor
  syncing,

  /// Error en cache o network
  error,
}

/// Configuración de cache para diferentes tipos de datos
class CacheConfig {
  final CacheStrategy strategy;
  final Duration ttl; // Time to live
  final bool enableOfflineMode;
  final int maxItems;

  const CacheConfig({
    required this.strategy,
    this.ttl = const Duration(hours: 24),
    this.enableOfflineMode = true,
    this.maxItems = 1000,
  });

  /// Configuración para lugares (datos críticos)
  static const places = CacheConfig(
    strategy: CacheStrategy.cacheFirst,
    ttl: Duration(hours: 12),
    maxItems: 500,
  );

  /// Configuración para categorías (datos estables)
  static const categories = CacheConfig(
    strategy: CacheStrategy.cacheFirst,
    ttl: Duration(days: 7),
    maxItems: 100,
  );

  /// Configuración para eventos (datos dinámicos)
  static const events = CacheConfig(
    strategy: CacheStrategy.networkFirst,
    ttl: Duration(hours: 6),
    maxItems: 200,
  );

  /// Configuración para favoritos (actualización rápida)
  static const favorites = CacheConfig(
    strategy: CacheStrategy.staleWhileRevalidate,
    ttl: Duration(hours: 1),
    maxItems: 100,
  );

  /// Configuración para lugares por ubicación (semi-dinámico)
  static const placesLocation = CacheConfig(
    strategy: CacheStrategy.staleWhileRevalidate,
    ttl: Duration(hours: 2),
    maxItems: 300,
  );
}
