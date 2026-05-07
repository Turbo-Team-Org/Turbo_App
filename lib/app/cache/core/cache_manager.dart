import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:turbo/app/cache/core/cache_strategy.dart';
import 'package:turbo/app/cache/data/cache_database.dart';

/// Gestor central del sistema de cache
class CacheManager {
  final CacheDatabase _database;

  /// Singleton instance
  static final CacheManager _instance = CacheManager._internal();
  factory CacheManager() => _instance;
  CacheManager._internal() : _database = CacheDatabase();

  /// Inicializa el cache manager
  Future<void> initialize() async {
    try {
      await _database.database;
      await _cleanExpiredItems();
    } catch (e) {
      throw Exception('Error al inicializar CacheManager: $e');
    }
  }

  /// Obtiene datos usando la estrategia de cache especificada
  Future<CacheResult<T>> getData<T>({
    required String type,
    required String id,
    required CacheConfig config,
    required Future<T> Function() networkCall,
    required T Function(Map<String, dynamic>) fromJson,
    required Map<String, dynamic> Function(T) toJson,
  }) async {
    try {
      switch (config.strategy) {
        case CacheStrategy.cacheFirst:
          return await _handleCacheFirst<T>(
            type: type,
            id: id,
            config: config,
            networkCall: networkCall,
            fromJson: fromJson,
            toJson: toJson,
          );

        case CacheStrategy.networkFirst:
          return await _handleNetworkFirst<T>(
            type: type,
            id: id,
            config: config,
            networkCall: networkCall,
            fromJson: fromJson,
            toJson: toJson,
          );

        case CacheStrategy.staleWhileRevalidate:
          return await _handleStaleWhileRevalidate<T>(
            type: type,
            id: id,
            config: config,
            networkCall: networkCall,
            fromJson: fromJson,
            toJson: toJson,
          );
      }
    } catch (e) {
      final cachedData = await _getCachedData<T>(type, id, fromJson);
      return CacheResult.error(
        message: 'Error en cache manager: $e',
        cachedData: cachedData,
        exception: e is Exception ? e : Exception(e.toString()),
      );
    }
  }

  /// Obtiene múltiples items de cache
  Future<CacheResult<List<T>>> getMultipleData<T>({
    required String type,
    required CacheConfig config,
    required Future<List<T>> Function() networkCall,
    required T Function(Map<String, dynamic>) fromJson,
    required Map<String, dynamic> Function(T) toJson,
  }) async {
    try {
      switch (config.strategy) {
        case CacheStrategy.cacheFirst:
          return await _handleMultipleCacheFirst<T>(
            type: type,
            config: config,
            networkCall: networkCall,
            fromJson: fromJson,
            toJson: toJson,
          );

        case CacheStrategy.networkFirst:
          return await _handleMultipleNetworkFirst<T>(
            type: type,
            config: config,
            networkCall: networkCall,
            fromJson: fromJson,
            toJson: toJson,
          );

        case CacheStrategy.staleWhileRevalidate:
          return await _handleMultipleStaleWhileRevalidate<T>(
            type: type,
            config: config,
            networkCall: networkCall,
            fromJson: fromJson,
            toJson: toJson,
          );
      }
    } catch (e) {
      final cachedData = await _getMultipleCachedData<T>(type, fromJson);
      return CacheResult.error(
        message: 'Error en cache manager múltiple: $e',
        cachedData: cachedData,
        exception: e is Exception ? e : Exception(e.toString()),
      );
    }
  }

  /// Estrategia Cache First - busca en cache primero
  Future<CacheResult<T>> _handleCacheFirst<T>({
    required String type,
    required String id,
    required CacheConfig config,
    required Future<T> Function() networkCall,
    required T Function(Map<String, dynamic>) fromJson,
    required Map<String, dynamic> Function(T) toJson,
  }) async {
    final cachedData = await _getCachedData<T>(type, id, fromJson);

    if (cachedData != null && await _isDataValid(type, id)) {
      return CacheResult.success(
        data: cachedData,
        fromCache: true,
        lastSyncAt: await _getLastSyncTime(type, id),
      );
    }

    try {
      final networkData = await networkCall();
      await _saveToCache(type, id, toJson(networkData), config.ttl);

      return CacheResult.success(
        data: networkData,
        fromCache: false,
        lastSyncAt: DateTime.now(),
      );
    } catch (e) {
      if (cachedData != null) {
        return CacheResult.success(
          data: cachedData,
          fromCache: true,
          lastSyncAt: await _getLastSyncTime(type, id),
        );
      }
      rethrow;
    }
  }

  /// Estrategia Network First - intenta network primero
  Future<CacheResult<T>> _handleNetworkFirst<T>({
    required String type,
    required String id,
    required CacheConfig config,
    required Future<T> Function() networkCall,
    required T Function(Map<String, dynamic>) fromJson,
    required Map<String, dynamic> Function(T) toJson,
  }) async {
    try {
      final networkData = await networkCall();
      await _saveToCache(type, id, toJson(networkData), config.ttl);

      return CacheResult.success(
        data: networkData,
        fromCache: false,
        lastSyncAt: DateTime.now(),
      );
    } catch (e) {
      final cachedData = await _getCachedData<T>(type, id, fromJson);
      if (cachedData != null) {
        return CacheResult.success(
          data: cachedData,
          fromCache: true,
          lastSyncAt: await _getLastSyncTime(type, id),
        );
      }
      rethrow;
    }
  }

  /// Estrategia Stale While Revalidate - devuelve cache y actualiza en background
  Future<CacheResult<T>> _handleStaleWhileRevalidate<T>({
    required String type,
    required String id,
    required CacheConfig config,
    required Future<T> Function() networkCall,
    required T Function(Map<String, dynamic>) fromJson,
    required Map<String, dynamic> Function(T) toJson,
  }) async {
    final cachedData = await _getCachedData<T>(type, id, fromJson);

    // Actualizar en background si es necesario
    if (!await _isDataValid(type, id)) {
      _updateInBackground<T>(type, id, config.ttl, networkCall, toJson);
    }

    if (cachedData != null) {
      return CacheResult.success(
        data: cachedData,
        fromCache: true,
        lastSyncAt: await _getLastSyncTime(type, id),
      );
    }

    // Si no hay cache, hacer llamada sincrónica
    try {
      final networkData = await networkCall();
      await _saveToCache(type, id, toJson(networkData), config.ttl);

      return CacheResult.success(
        data: networkData,
        fromCache: false,
        lastSyncAt: DateTime.now(),
      );
    } catch (e) {
      rethrow;
    }
  }

  /// Maneja múltiples items con estrategia Cache First
  Future<CacheResult<List<T>>> _handleMultipleCacheFirst<T>({
    required String type,
    required CacheConfig config,
    required Future<List<T>> Function() networkCall,
    required T Function(Map<String, dynamic>) fromJson,
    required Map<String, dynamic> Function(T) toJson,
  }) async {
    final cachedData = await _getMultipleCachedData<T>(type, fromJson);

    if (cachedData.isNotEmpty && await _isTypeDataFresh(type, config.ttl)) {
      return CacheResult.success(
        data: cachedData,
        fromCache: true,
        lastSyncAt: await _getTypeLastSyncTime(type),
      );
    }

    try {
      final networkData = await networkCall();
      await _saveMultipleToCache(type, networkData, toJson, config.ttl);

      return CacheResult.success(
        data: networkData,
        fromCache: false,
        lastSyncAt: DateTime.now(),
      );
    } catch (e) {
      if (cachedData.isNotEmpty) {
        return CacheResult.success(
          data: cachedData,
          fromCache: true,
          lastSyncAt: await _getTypeLastSyncTime(type),
        );
      }
      rethrow;
    }
  }

  /// Maneja múltiples items con estrategia Network First
  Future<CacheResult<List<T>>> _handleMultipleNetworkFirst<T>({
    required String type,
    required CacheConfig config,
    required Future<List<T>> Function() networkCall,
    required T Function(Map<String, dynamic>) fromJson,
    required Map<String, dynamic> Function(T) toJson,
  }) async {
    try {
      final networkData = await networkCall();
      await _saveMultipleToCache(type, networkData, toJson, config.ttl);

      return CacheResult.success(
        data: networkData,
        fromCache: false,
        lastSyncAt: DateTime.now(),
      );
    } catch (e) {
      final cachedData = await _getMultipleCachedData<T>(type, fromJson);
      if (cachedData.isNotEmpty) {
        return CacheResult.success(
          data: cachedData,
          fromCache: true,
          lastSyncAt: await _getTypeLastSyncTime(type),
        );
      }
      rethrow;
    }
  }

  /// Maneja múltiples items con estrategia Stale While Revalidate
  Future<CacheResult<List<T>>> _handleMultipleStaleWhileRevalidate<T>({
    required String type,
    required CacheConfig config,
    required Future<List<T>> Function() networkCall,
    required T Function(Map<String, dynamic>) fromJson,
    required Map<String, dynamic> Function(T) toJson,
  }) async {
    final cachedData = await _getMultipleCachedData<T>(type, fromJson);

    // Actualizar en background si es necesario
    if (!await _isTypeDataFresh(type, config.ttl)) {
      _updateMultipleInBackground<T>(type, config.ttl, networkCall, toJson);
    }

    if (cachedData.isNotEmpty) {
      return CacheResult.success(
        data: cachedData,
        fromCache: true,
        lastSyncAt: await _getTypeLastSyncTime(type),
      );
    }

    // Si no hay cache, hacer llamada sincrónica
    try {
      final networkData = await networkCall();
      await _saveMultipleToCache(type, networkData, toJson, config.ttl);

      return CacheResult.success(
        data: networkData,
        fromCache: false,
        lastSyncAt: DateTime.now(),
      );
    } catch (e) {
      rethrow;
    }
  }

  /// Obtiene datos cacheados
  Future<T?> _getCachedData<T>(
    String type,
    String id,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    try {
      final cachedItem = await _database.getItem(type, id);
      if (cachedItem != null && cachedItem['data'] != null) {
        return fromJson(cachedItem['data']);
      }
    } catch (e) {
      // Ignorar errores de deserialización
    }
    return null;
  }

  /// Obtiene múltiples datos cacheados
  Future<List<T>> _getMultipleCachedData<T>(
    String type,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    try {
      final cachedItems = await _database.getAllItems(type);
      final validItems = <T>[];

      for (final item in cachedItems) {
        if (item['data'] != null) {
          try {
            final parsedItem = fromJson(item['data']);
            validItems.add(parsedItem);
          } catch (e) {
            // Ignorar items que no se pueden deserializar
          }
        }
      }

      return validItems;
    } catch (e) {
      return [];
    }
  }

  /// Guarda datos en cache
  Future<void> _saveToCache(
    String type,
    String id,
    Map<String, dynamic> data,
    Duration ttl,
  ) async {
    final now = DateTime.now();
    final expiryTime = now.add(ttl);
    final dataHash = _generateHash(data);

    final cacheItem = {
      'data': data,
      'cachedAt': now.toIso8601String(),
      'expiresAt': expiryTime.toIso8601String(),
      'dataHash': dataHash,
      'version': 1,
    };

    await _database.putItem(type, id, cacheItem);
  }

  /// Guarda múltiples datos en cache
  Future<void> _saveMultipleToCache<T>(
    String type,
    List<T> items,
    Map<String, dynamic> Function(T) toJson,
    Duration ttl,
  ) async {
    // Limpiar cache existente del tipo
    await _database.clearType(type);

    final now = DateTime.now();
    final expiryTime = now.add(ttl);

    for (int i = 0; i < items.length; i++) {
      final item = items[i];
      final data = toJson(item);
      final id = data['id']?.toString() ?? i.toString();
      await _saveToCache(type, id, data, ttl);
    }

    // Guardar metadata de sincronización
    await _database.putItem('metadata', '${type}_sync', {
      'lastSyncAt': now.toIso8601String(),
      'itemCount': items.length,
    });
  }

  /// Verifica si los datos son válidos (no expirados)
  Future<bool> _isDataValid(String type, String id) async {
    try {
      final cachedItem = await _database.getItem(type, id);
      if (cachedItem == null) return false;

      final expiresAt = DateTime.tryParse(cachedItem['expiresAt'] ?? '');
      if (expiresAt == null) return false;

      return expiresAt.isAfter(DateTime.now());
    } catch (e) {
      return false;
    }
  }

  /// Verifica si los datos de un tipo son frescos
  Future<bool> _isTypeDataFresh(String type, Duration ttl) async {
    try {
      final metadata = await _database.getItem('metadata', '${type}_sync');
      if (metadata == null) return false;

      final lastSyncAt = DateTime.tryParse(metadata['lastSyncAt'] ?? '');
      if (lastSyncAt == null) return false;

      final expiryTime = lastSyncAt.add(ttl);
      return expiryTime.isAfter(DateTime.now());
    } catch (e) {
      return false;
    }
  }

  /// Obtiene el tiempo de última sincronización
  Future<DateTime?> _getLastSyncTime(String type, String id) async {
    try {
      final cachedItem = await _database.getItem(type, id);
      if (cachedItem == null) return null;

      return DateTime.tryParse(cachedItem['cachedAt'] ?? '');
    } catch (e) {
      return null;
    }
  }

  /// Obtiene el tiempo de última sincronización de un tipo
  Future<DateTime?> _getTypeLastSyncTime(String type) async {
    try {
      final metadata = await _database.getItem('metadata', '${type}_sync');
      if (metadata == null) return null;

      return DateTime.tryParse(metadata['lastSyncAt'] ?? '');
    } catch (e) {
      return null;
    }
  }

  /// Actualiza datos en background
  void _updateInBackground<T>(
    String type,
    String id,
    Duration ttl,
    Future<T> Function() networkCall,
    Map<String, dynamic> Function(T) toJson,
  ) {
    unawaited(() async {
      try {
        final networkData = await networkCall();
        await _saveToCache(type, id, toJson(networkData), ttl);
      } catch (e) {
        // Ignorar errores en background updates
      }
    });
  }

  /// Actualiza múltiples datos en background
  void _updateMultipleInBackground<T>(
    String type,
    Duration ttl,
    Future<List<T>> Function() networkCall,
    Map<String, dynamic> Function(T) toJson,
  ) {
    unawaited(() async {
      try {
        final networkData = await networkCall();
        await _saveMultipleToCache(type, networkData, toJson, ttl);
      } catch (e) {
        // Ignorar errores en background updates
      }
    });
  }

  /// Limpia items expirados
  Future<void> _cleanExpiredItems() async {
    try {
      final types = ['places', 'categories', 'events', 'favorites', 'reviews'];

      for (final type in types) {
        final items = await _database.getAllItems(type);
        final now = DateTime.now();

        for (final item in items) {
          final expiresAt = DateTime.tryParse(item['expiresAt'] ?? '');
          if (expiresAt != null && expiresAt.isBefore(now)) {
            await _database.deleteItem(type, item['id']);
          }
        }
      }
    } catch (e) {
      // Ignorar errores en limpieza
    }
  }

  /// Genera hash de los datos para verificar integridad
  String _generateHash(Map<String, dynamic> data) {
    final jsonString = jsonEncode(data);
    final bytes = utf8.encode(jsonString);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Obtiene información del cache
  Future<CacheInfo> getCacheInfo(String type) async {
    final stats = await _database.getCacheStats(type);
    final lastSyncAt = await _getTypeLastSyncTime(type) ?? DateTime.now();
    final sizeInBytes = await _database.getDatabaseSize();

    return CacheInfo(
      type: type,
      totalItems: stats['total'] ?? 0,
      validItems: stats['valid'] ?? 0,
      expiredItems: stats['expired'] ?? 0,
      lastSyncAt: lastSyncAt,
      sizeInBytes: sizeInBytes,
    );
  }

  /// Limpia cache de un tipo específico
  Future<void> clearCache(String type) async {
    await _database.clearType(type);
    await _database.deleteItem('metadata', '${type}_sync');
  }

  /// Limpia todo el cache
  Future<void> clearAllCache() async {
    await _database.clearAll();
  }

  /// Verifica si hay conexión a internet
  Future<bool> hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  /// Cierra el cache manager
  Future<void> dispose() async {
    await _database.close();
  }
}

/// Helper para operaciones asíncronas sin esperar
void unawaited(Future<void> Function() operation) {
  operation();
}

/// Clase simplificada para CacheInfo (sin freezed por ahora)
class CacheInfo {
  final String type;
  final int totalItems;
  final int validItems;
  final int expiredItems;
  final DateTime lastSyncAt;
  final int sizeInBytes;

  const CacheInfo({
    required this.type,
    required this.totalItems,
    required this.validItems,
    required this.expiredItems,
    required this.lastSyncAt,
    required this.sizeInBytes,
  });
}

/// Clase simplificada para CacheResult (sin freezed por ahora)
abstract class CacheResult<T> {
  const CacheResult();

  factory CacheResult.success({
    required T data,
    required bool fromCache,
    DateTime? lastSyncAt,
  }) = CacheSuccess<T>;

  factory CacheResult.loading({T? cachedData}) = CacheLoading<T>;

  factory CacheResult.error({
    required String message,
    T? cachedData,
    Exception? exception,
  }) = CacheError<T>;
}

class CacheSuccess<T> extends CacheResult<T> {
  final T data;
  final bool fromCache;
  final DateTime? lastSyncAt;

  const CacheSuccess({
    required this.data,
    required this.fromCache,
    this.lastSyncAt,
  });
}

class CacheLoading<T> extends CacheResult<T> {
  final T? cachedData;

  const CacheLoading({this.cachedData});
}

class CacheError<T> extends CacheResult<T> {
  final String message;
  final T? cachedData;
  final Exception? exception;

  const CacheError({required this.message, this.cachedData, this.exception});
}
