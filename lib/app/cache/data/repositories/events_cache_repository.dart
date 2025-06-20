import 'package:core/core.dart';
import 'package:turbo/app/cache/core/cache_manager.dart';
import 'package:turbo/app/cache/core/cache_strategy.dart';

/// Repository de cache para Events con estrategia Network-First
/// Datos dinámicos que cambian frecuentemente
class EventsCacheRepository {
  final CacheManager _cacheManager;
  final EventRepository _networkRepository;

  EventsCacheRepository({
    required CacheManager cacheManager,
    required EventRepository networkRepository,
  }) : _cacheManager = cacheManager,
       _networkRepository = networkRepository;

  /// Obtiene todos los eventos usando cache con prioridad de red
  Future<CacheResult<List<Event>>> getEvents() async {
    return await _cacheManager.getMultipleData<Event>(
      type: 'events',
      config: CacheConfig.events,
      networkCall: () => _networkRepository.getEvents(),
      fromJson: (json) => Event.fromJson(json),
      toJson: (event) => event.toJson(),
    );
  }

  /// Obtiene eventos de hoy usando cache
  Future<CacheResult<List<Event>>> getTodayEvents() async {
    return await _cacheManager.getMultipleData<Event>(
      type: 'today_events',
      config: CacheConfig.events,
      networkCall: () => _networkRepository.getTodayEvents(),
      fromJson: (json) => Event.fromJson(json),
      toJson: (event) => event.toJson(),
    );
  }

  /// Sincroniza eventos en background
  Future<void> syncEvents() async {
    try {
      // Sincronizar todos los eventos
      await getEvents();

      // Sincronizar eventos de hoy (más críticos)
      await getTodayEvents();

      print('Events Cache: Sincronización completada');
    } catch (e) {
      print('Events Cache: Error en sincronización - $e');
    }
  }

  /// Pre-carga eventos para mejor rendimiento
  Future<void> preloadEvents() async {
    try {
      // Pre-cargar eventos de hoy de forma prioritaria
      await getTodayEvents();
    } catch (e) {
      // Pre-carga silenciosa
      print('Events Cache: Error en pre-carga - $e');
    }
  }
}
