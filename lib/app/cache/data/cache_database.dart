import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

/// Gestor de la base de datos de cache usando Sembast
class CacheDatabase {
  static const String _dbName = 'turbo_cache.db';
  static const int _dbVersion = 1;

  Database? _database;

  // Stores para diferentes tipos de datos
  static final placesStore = stringMapStoreFactory.store('places');
  static final categoriesStore = stringMapStoreFactory.store('categories');
  static final eventsStore = stringMapStoreFactory.store('events');
  static final favoritesStore = stringMapStoreFactory.store('favorites');
  static final reviewsStore = stringMapStoreFactory.store('reviews');
  static final metadataStore = stringMapStoreFactory.store('metadata');

  /// Singleton instance
  static final CacheDatabase _instance = CacheDatabase._internal();
  factory CacheDatabase() => _instance;
  CacheDatabase._internal();

  /// Obtiene la instancia de la base de datos
  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  /// Inicializa la base de datos
  Future<Database> _initDatabase() async {
    try {
      final appDocumentDir = await getApplicationDocumentsDirectory();
      final dbPath = join(appDocumentDir.path, _dbName);

      return await databaseFactoryIo.openDatabase(
        dbPath,
        version: _dbVersion,
        onVersionChanged: _onVersionChanged,
      );
    } catch (e) {
      throw Exception('Error al inicializar la base de datos de cache: $e');
    }
  }

  /// Maneja cambios de versión de la base de datos
  Future<void> _onVersionChanged(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {
    // Aquí se pueden manejar migraciones de datos si es necesario
    if (oldVersion < newVersion) {
      // Lógica de migración futura
    }
  }

  /// Obtiene un store específico por tipo
  StoreRef<String, Map<String, Object?>> getStore(String type) {
    switch (type.toLowerCase()) {
      case 'places':
        return placesStore;
      case 'categories':
        return categoriesStore;
      case 'events':
        return eventsStore;
      case 'favorites':
        return favoritesStore;
      case 'reviews':
        return reviewsStore;
      case 'metadata':
        return metadataStore;
      default:
        return stringMapStoreFactory.store(type);
    }
  }

  /// Obtiene un item del cache por ID y tipo
  Future<Map<String, dynamic>?> getItem(String type, String id) async {
    try {
      final db = await database;
      final store = getStore(type);
      final record = await store.record(id).get(db);
      return record?.cast<String, dynamic>();
    } catch (e) {
      return null;
    }
  }

  /// Guarda un item en el cache
  Future<void> putItem(
    String type,
    String id,
    Map<String, dynamic> data,
  ) async {
    try {
      final db = await database;
      final store = getStore(type);
      await store.record(id).put(db, data);
    } catch (e) {
      throw Exception('Error al guardar item en cache: $e');
    }
  }

  /// Obtiene todos los items de un tipo
  Future<List<Map<String, dynamic>>> getAllItems(String type) async {
    try {
      final db = await database;
      final store = getStore(type);
      final records = await store.find(db);
      return records
          .map(
            (record) => {
              'id': record.key,
              ...record.value.cast<String, dynamic>(),
            },
          )
          .toList();
    } catch (e) {
      return [];
    }
  }

  /// Elimina un item del cache
  Future<void> deleteItem(String type, String id) async {
    try {
      final db = await database;
      final store = getStore(type);
      await store.record(id).delete(db);
    } catch (e) {
      throw Exception('Error al eliminar item del cache: $e');
    }
  }

  /// Limpia todos los items de un tipo
  Future<void> clearType(String type) async {
    try {
      final db = await database;
      final store = getStore(type);
      await store.delete(db);
    } catch (e) {
      throw Exception('Error al limpiar cache del tipo $type: $e');
    }
  }

  /// Limpia toda la base de datos
  Future<void> clearAll() async {
    try {
      final db = await database;
      await db.close();

      final appDocumentDir = await getApplicationDocumentsDirectory();
      final dbPath = join(appDocumentDir.path, _dbName);
      final dbFile = File(dbPath);

      if (await dbFile.exists()) {
        await dbFile.delete();
      }

      _database = null;
    } catch (e) {
      throw Exception('Error al limpiar toda la base de datos: $e');
    }
  }

  /// Obtiene el tamaño de la base de datos en bytes
  Future<int> getDatabaseSize() async {
    try {
      final appDocumentDir = await getApplicationDocumentsDirectory();
      final dbPath = join(appDocumentDir.path, _dbName);
      final dbFile = File(dbPath);

      if (await dbFile.exists()) {
        final stat = await dbFile.stat();
        return stat.size;
      }
      return 0;
    } catch (e) {
      return 0;
    }
  }

  /// Obtiene estadísticas del cache por tipo
  Future<Map<String, int>> getCacheStats(String type) async {
    try {
      final db = await database;
      final store = getStore(type);
      final records = await store.find(db);

      final now = DateTime.now();
      int validItems = 0;
      int expiredItems = 0;

      for (final record in records) {
        final data = record.value.cast<String, dynamic>();
        final expiresAt = DateTime.tryParse(data['expiresAt'] ?? '');

        if (expiresAt != null && expiresAt.isAfter(now)) {
          validItems++;
        } else {
          expiredItems++;
        }
      }

      return {
        'total': records.length,
        'valid': validItems,
        'expired': expiredItems,
      };
    } catch (e) {
      return {'total': 0, 'valid': 0, 'expired': 0};
    }
  }

  /// Cierra la base de datos
  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
}
