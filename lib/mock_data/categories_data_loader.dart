import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

/// Cargador de datos para categorías de lugares y negocios
/// Permite cargar categorías predefinidas a Firestore
class CategoriesDataLoader {
  final FirebaseFirestore _firestore;
  final Uuid _uuid = const Uuid();

  CategoriesDataLoader({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  /// Categorías predefinidas para lugares y negocios en español
  List<Map<String, dynamic>> get sampleCategories => [
    // Categorías populares destacadas
    {
      'id': 'cat_restaurants',
      'name': 'Restaurantes',
      'icon': '0xe56c', // restaurant
      'description': 'Los mejores lugares para comer en Cuba',
      'imageUrl':
          'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?q=80&w=1000',
      'isFeatured': true,
      'metadata': {'tipo': 'gastronomía', 'orden': 1},
    },
    {
      'id': 'cat_bars',
      'name': 'Bares y Discotecas',
      'icon': '0xe540', // local_bar
      'description': 'Disfruta de la vida nocturna cubana',
      'imageUrl':
          'https://images.unsplash.com/photo-1572116469696-31de0f17cc34?q=80&w=1000',
      'isFeatured': true,
      'metadata': {'tipo': 'entretenimiento', 'orden': 2},
    },
    {
      'id': 'cat_cafes',
      'name': 'Cafeterías',
      'icon': '0xe541', // local_cafe
      'description': 'El mejor café y ambiente relajado',
      'imageUrl':
          'https://images.unsplash.com/photo-1501339847302-ac426a4a7cbb?q=80&w=1000',
      'isFeatured': true,
      'metadata': {'tipo': 'gastronomía', 'orden': 3},
    },
    {
      'id': 'cat_hotels',
      'name': 'Hoteles y Hospedaje',
      'icon': '0xe57f', // hotel
      'description': 'Opciones de alojamiento para todos los gustos',
      'imageUrl':
          'https://images.unsplash.com/photo-1590073242678-70ee3fc28f8e?q=80&w=1000',
      'isFeatured': true,
      'metadata': {'tipo': 'alojamiento', 'orden': 4},
    },
    // Categorías adicionales
    {
      'id': 'cat_paladares',
      'name': 'Paladares',
      'icon': '0xe556', // restaurant_menu
      'description': 'Auténticos restaurantes familiares cubanos',
      'imageUrl':
          'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?q=80&w=1000',
      'isFeatured': false,
      'metadata': {'tipo': 'gastronomía', 'tradicional': true, 'orden': 5},
    },
    {
      'id': 'cat_culture',
      'name': 'Cultura',
      'icon': '0xe3fa', // museum
      'description': 'Museos, galerías y sitios históricos',
      'imageUrl':
          'https://images.unsplash.com/photo-1518998053901-5348d3961a04?q=80&w=1000',
      'isFeatured': false,
      'metadata': {'tipo': 'entretenimiento', 'cultural': true, 'orden': 6},
    },
    {
      'id': 'cat_beaches',
      'name': 'Playas',
      'icon': '0xe3b7', // beach_access
      'description': 'Las mejores playas del Caribe',
      'imageUrl':
          'https://images.unsplash.com/photo-1590523741831-ab7e8b8f9c7f?q=80&w=1000',
      'isFeatured': true,
      'metadata': {'tipo': 'naturaleza', 'orden': 7},
    },
    {
      'id': 'cat_cigars',
      'name': 'Tabaco y Puros',
      'icon': '0xe50d', // smoking_rooms
      'description': 'Tiendas y fábricas de puros cubanos',
      'imageUrl':
          'https://images.unsplash.com/photo-1576010464639-64e1cede4cc3?q=80&w=1000',
      'isFeatured': false,
      'metadata': {'tipo': 'tiendas', 'tradicional': true, 'orden': 8},
    },
    {
      'id': 'cat_markets',
      'name': 'Mercados',
      'icon': '0xe8f6', // store
      'description': 'Mercados locales y artesanías',
      'imageUrl':
          'https://images.unsplash.com/photo-1578916171728-46686eac8d58?q=80&w=1000',
      'isFeatured': false,
      'metadata': {'tipo': 'compras', 'orden': 9},
    },
    {
      'id': 'cat_nightlife',
      'name': 'Vida Nocturna',
      'icon': '0xe405', // nightlife
      'description': 'Los mejores lugares para disfrutar la noche',
      'imageUrl':
          'https://images.unsplash.com/photo-1579952363873-27f3bade9f55?q=80&w=1000',
      'isFeatured': false,
      'metadata': {'tipo': 'entretenimiento', 'orden': 10},
    },
    {
      'id': 'cat_music',
      'name': 'Música en Vivo',
      'icon': '0xe029', // audio_file
      'description': 'Lugares con los mejores ritmos cubanos',
      'imageUrl':
          'https://images.unsplash.com/photo-1510915361894-db8b60106cb1?q=80&w=1000',
      'isFeatured': false,
      'metadata': {'tipo': 'entretenimiento', 'cultural': true, 'orden': 11},
    },
    {
      'id': 'cat_bodegones',
      'name': 'Bodegones',
      'icon': '0xe8ee', // storefront
      'description': 'Tiendas de productos seleccionados',
      'imageUrl':
          'https://images.unsplash.com/photo-1534723452862-4c874018d66d?q=80&w=1000',
      'isFeatured': false,
      'metadata': {'tipo': 'compras', 'orden': 12},
    },
    {
      'id': 'cat_sports',
      'name': 'Deportes',
      'icon': '0xea80', // sports_baseball
      'description': 'Actividades deportivas y recreativas',
      'imageUrl':
          'https://images.unsplash.com/photo-1471295253337-3ceaaedca402?q=80&w=1000',
      'isFeatured': false,
      'metadata': {'tipo': 'entretenimiento', 'orden': 13},
    },
    {
      'id': 'cat_beauty',
      'name': 'Belleza y Spa',
      'icon': '0xe577', // spa
      'description': 'Salones de belleza, barberías y spas',
      'imageUrl':
          'https://images.unsplash.com/photo-1560750588-73207b1ef5b8?q=80&w=1000',
      'isFeatured': false,
      'metadata': {'tipo': 'servicios', 'orden': 14},
    },
    {
      'id': 'cat_tours',
      'name': 'Tours y Guías',
      'icon': '0xe55e', // tour
      'description': 'Las mejores experiencias guiadas',
      'imageUrl':
          'https://images.unsplash.com/photo-1527786356703-4b100091cd2c?q=80&w=1000',
      'isFeatured': false,
      'metadata': {'tipo': 'servicios', 'turismo': true, 'orden': 15},
    },
  ];

  /// Convierte strings de iconos a códigos enteros para MaterialIcons
  String _convertIconToCodePoint(String iconString) {
    if (iconString.startsWith('0x')) {
      // Si ya es un código hexadecimal, convertir a entero
      try {
        int codePoint = int.parse(iconString.substring(2), radix: 16);
        return codePoint.toString();
      } catch (e) {
        print('Error convirtiendo icono $iconString: $e');
        return '0xe5d3'; // category - icono por defecto
      }
    }
    return iconString;
  }

  /// Carga todas las categorías a Firestore
  Future<void> loadCategoriesToFirestore() async {
    final batch = _firestore.batch();
    final categoriesCollection = _firestore.collection('categories');

    // Primero limpiar colección existente
    final existingCategories = await categoriesCollection.get();
    for (var doc in existingCategories.docs) {
      batch.delete(doc.reference);
    }

    // Agregar todas las categorías
    for (var category in sampleCategories) {
      final id = category['id'] ?? _uuid.v4();
      final docRef = categoriesCollection.doc(id);

      // Convertir icono si es necesario
      final iconValue = category['icon'] as String;
      final processedIcon = _convertIconToCodePoint(iconValue);

      // Crear documento con los datos procesados
      final categoryData = {
        ...category,
        'id': id,
        'icon': processedIcon,
        'placesCount': category['placesCount'] ?? 0,
        'isFeatured': category['isFeatured'] ?? false,
        'metadata': category['metadata'] ?? {},
        'createdAt': FieldValue.serverTimestamp(),
      };

      // Eliminar el campo ID para evitar duplicación
      categoryData.remove('id');

      batch.set(docRef, categoryData);
    }

    // Ejecutar el batch
    await batch.commit();
    print('✅ ${sampleCategories.length} categorías cargadas a Firestore');
  }

  /// Asignar categorías aleatorias a lugares existentes
  Future<void> assignRandomCategoriesToPlaces() async {
    final placesCollection = _firestore.collection('places');
    final categoriesCollection = _firestore.collection('categories');
    final placeCategoriesCollection = _firestore.collection('place_categories');

    // Obtener todos los lugares
    final placesSnapshot = await placesCollection.get();
    if (placesSnapshot.docs.isEmpty) {
      print('⚠️ No hay lugares para asignar categorías');
      return;
    }

    // Obtener todas las categorías
    final categoriesSnapshot = await categoriesCollection.get();
    if (categoriesSnapshot.docs.isEmpty) {
      print('⚠️ No hay categorías disponibles');
      return;
    }

    final categories = categoriesSnapshot.docs;
    final batch = _firestore.batch();

    // Primero limpiar asociaciones existentes
    final existingAssociations = await placeCategoriesCollection.get();
    for (var doc in existingAssociations.docs) {
      batch.delete(doc.reference);
    }

    // Contador para categorías
    Map<String, int> categoryCounter = {};
    categories.forEach((category) {
      categoryCounter[category.id] = 0;
    });

    // Asignar categorías a lugares
    for (var place in placesSnapshot.docs) {
      final placeId = place.id;
      final placeData = place.data();
      final placeName = placeData['name'] as String? ?? '';

      // Determinar cuántas categorías asignar (1-3)
      int numCategories = 1 + (placeId.hashCode % 3);
      List<String> assignedCategories = [];

      // Asignar categorías basadas en el nombre o tipo de lugar
      for (var category in categories) {
        final categoryData = category.data();
        final categoryName = categoryData['name'] as String? ?? '';
        final categoryType =
            (categoryData['metadata'] as Map<String, dynamic>?)?['tipo']
                as String? ??
            '';

        bool shouldAssign = false;

        // Lógica para asignar categorías
        if (placeName.toLowerCase().contains('restaurante') &&
            categoryName.contains('Restaurante')) {
          shouldAssign = true;
        } else if (placeName.toLowerCase().contains('café') &&
            categoryName.contains('Cafeterías')) {
          shouldAssign = true;
        } else if (placeName.toLowerCase().contains('bar') &&
            categoryName.contains('Bares')) {
          shouldAssign = true;
        } else if (placeName.toLowerCase().contains('hotel') &&
            categoryName.contains('Hoteles')) {
          shouldAssign = true;
        } else if (placeName.toLowerCase().contains('playa') &&
            categoryName.contains('Playas')) {
          shouldAssign = true;
        } else if (placeName.toLowerCase().contains('paladar') &&
            categoryName.contains('Paladares')) {
          shouldAssign = true;
        }

        // Si ya tenemos suficientes categorías, salir
        if (shouldAssign) {
          assignedCategories.add(category.id);
          if (assignedCategories.length >= numCategories) {
            break;
          }
        }
      }

      // Si no se encontraron categorías específicas, asignar aleatorias
      while (assignedCategories.length < numCategories) {
        final randomIndex = placeId.hashCode % categories.length;
        final categoryId = categories[randomIndex.abs()].id;
        if (!assignedCategories.contains(categoryId)) {
          assignedCategories.add(categoryId);
        }
      }

      // Crear asociaciones
      for (var categoryId in assignedCategories) {
        final docRef = placeCategoriesCollection.doc();
        batch.set(docRef, {
          'placeId': placeId,
          'categoryId': categoryId,
          'createdAt': FieldValue.serverTimestamp(),
        });

        // Incrementar contador
        categoryCounter[categoryId] = (categoryCounter[categoryId] ?? 0) + 1;
      }
    }

    // Actualizar contadores de lugares en categorías
    for (var entry in categoryCounter.entries) {
      if (entry.value > 0) {
        batch.update(categoriesCollection.doc(entry.key), {
          'placesCount': entry.value,
        });
      }
    }

    // Ejecutar el batch
    await batch.commit();
    print('✅ Categorías asignadas a ${placesSnapshot.docs.length} lugares');
  }

  /// Método principal para cargar categorías y asignarlas a lugares
  Future<void> loadAll() async {
    try {
      print('🚀 Iniciando carga de datos de categorías...');
      await loadCategoriesToFirestore();
      await assignRandomCategoriesToPlaces();
      print('✅ Carga de datos de categorías completada');
    } catch (e, stackTrace) {
      print('❌ Error cargando datos de categorías: $e');
      print(stackTrace);
    }
  }
}
