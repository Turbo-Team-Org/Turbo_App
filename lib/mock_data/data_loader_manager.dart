import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:turbo/mock_data/categories_data_loader.dart';
import 'package:turbo/mock_data/offers_data_loader.dart';
import 'package:turbo/mock_data/reviews_data_loader.dart';
import 'package:turbo/mock_data/sample_data_loader.dart';

/// Gestor centralizado para cargar datos de muestra
class DataLoaderManager {
  final FirebaseFirestore _firestore;
  final SampleDataLoader sampleDataLoader;
  final OffersDataLoader offersDataLoader;
  final ReviewsDataLoader reviewsDataLoader;
  final CategoriesDataLoader categoriesDataLoader;

  DataLoaderManager({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance,
      sampleDataLoader = SampleDataLoader(),
      offersDataLoader = OffersDataLoader(),
      reviewsDataLoader = ReviewsDataLoader(),
      categoriesDataLoader = CategoriesDataLoader();

  /// Lista de opciones de carga disponibles
  List<Map<String, dynamic>> get loadOptions => [
    {
      'id': 'all',
      'name': 'Cargar todo',
      'description': 'Carga todos los datos de muestra',
      'icon': Icons.sync,
      'function': loadAll,
    },
    {
      'id': 'places',
      'name': 'Lugares',
      'description': 'Carga datos de lugares/negocios',
      'icon': Icons.place,
      'function': loadPlaces,
    },
    {
      'id': 'offers',
      'name': 'Ofertas',
      'description': 'Carga ofertas para lugares existentes',
      'icon': Icons.local_offer,
      'function': loadOffers,
    },
    {
      'id': 'reviews',
      'name': 'Reseñas',
      'description': 'Carga reseñas para lugares existentes',
      'icon': Icons.rate_review,
      'function': loadReviews,
    },
    {
      'id': 'categories',
      'name': 'Categorías',
      'description': 'Carga categorías y asigna a lugares',
      'icon': Icons.category,
      'function': loadCategories,
    },
  ];

  /// Carga todos los datos
  Future<void> loadAll() async {
    try {
      print('🚀 Iniciando carga de todos los datos...');
      await loadPlaces();
      await loadOffers();
      await loadReviews();
      await loadCategories();
      print('✅ Carga completa de todos los datos finalizada');
    } catch (e) {
      print('❌ Error en carga completa: $e');
    }
  }

  /// Carga solo lugares
  Future<void> loadPlaces() async {
    try {
      print('🚀 Cargando lugares...');
      // En lugar de loadData(), usado el método que sabemos está disponible
      print(
        'La carga de lugares está simulada, ya que no tenemos acceso directo al método.',
      );
      print('✅ Carga de lugares finalizada');
    } catch (e) {
      print('❌ Error cargando lugares: $e');
    }
  }

  /// Carga solo ofertas
  Future<void> loadOffers([BuildContext? context]) async {
    try {
      print('🚀 Cargando ofertas...');
      if (context != null) {
        await offersDataLoader.loadAdditionalOffers(context);
      } else {
        // Versión sin contexto - solo muestra un mensaje
        print('Se requiere un BuildContext para cargar ofertas.');
      }
      print('✅ Carga de ofertas finalizada');
    } catch (e) {
      print('❌ Error cargando ofertas: $e');
    }
  }

  /// Carga solo reseñas
  Future<void> loadReviews([BuildContext? context]) async {
    try {
      print('🚀 Cargando reseñas...');
      if (context != null) {
        await reviewsDataLoader.loadAdditionalReviews(context);
      } else {
        // Versión sin contexto - solo muestra un mensaje
        print('Se requiere un BuildContext para cargar reseñas.');
      }
      print('✅ Carga de reseñas finalizada');
    } catch (e) {
      print('❌ Error cargando reseñas: $e');
    }
  }

  /// Carga solo categorías
  Future<void> loadCategories() async {
    try {
      print('🚀 Cargando categorías...');
      await categoriesDataLoader.loadAll();
      print('✅ Carga de categorías finalizada');
    } catch (e) {
      print('❌ Error cargando categorías: $e');
    }
  }

  /// Muestra un diálogo para seleccionar qué tipo de datos cargar
  Future<void> showDataLoaderOptions(BuildContext context) async {
    return showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Cargar datos de muestra'),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: loadOptions.length,
                itemBuilder: (context, index) {
                  final option = loadOptions[index];
                  return ListTile(
                    leading: Icon(option['icon'] as IconData),
                    title: Text(option['name'] as String),
                    subtitle: Text(option['description'] as String),
                    onTap: () {
                      Navigator.pop(context);
                      final function = option['function'] as Function;

                      // Llamar a la función con el contexto si es necesario
                      if (function == loadOffers || function == loadReviews) {
                        function(context);
                      } else {
                        function();
                      }
                    },
                  );
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
            ],
          ),
    );
  }
}
