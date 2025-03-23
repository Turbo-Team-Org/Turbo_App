import 'package:flutter/material.dart';
import 'package:turbo/utils/offers_data_loader.dart';
import 'package:turbo/utils/reviews_data_loader.dart';

/// Clase manager para facilitar la carga de distintos tipos de datos de muestra
class DataLoaderManager {
  final OffersDataLoader _offersLoader = OffersDataLoader();
  final ReviewsDataLoader _reviewsLoader = ReviewsDataLoader();

  /// Muestra un diálogo para seleccionar qué tipo de datos cargar
  Future<void> showDataLoaderOptions(BuildContext context) async {
    return showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Cargar datos de muestra'),
            content: const Text('Selecciona qué tipo de datos quieres cargar:'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _loadOffers(context);
                },
                child: const Text('Ofertas'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _loadReviews(context);
                },
                child: const Text('Reseñas'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _loadBoth(context);
                },
                child: const Text('Ambos'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancelar'),
              ),
            ],
          ),
    );
  }

  /// Carga solo ofertas adicionales
  Future<void> _loadOffers(BuildContext context) async {
    await _offersLoader.loadAdditionalOffers(context);
  }

  /// Carga solo reseñas adicionales
  Future<void> _loadReviews(BuildContext context) async {
    await _reviewsLoader.loadAdditionalReviews(context);
  }

  /// Carga tanto ofertas como reseñas
  Future<void> _loadBoth(BuildContext context) async {
    // Primero cargar ofertas
    await _offersLoader.loadAdditionalOffers(context);

    // Luego cargar reseñas
    if (context.mounted) {
      await _reviewsLoader.loadAdditionalReviews(context);
    }
  }
}
