import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:math';

/// Clase para cargar reseñas adicionales en lugares existentes
class ReviewsDataLoader {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Random _random = Random();

  /// Carga reseñas adicionales en Firestore para lugares existentes
  Future<void> loadAdditionalReviews(BuildContext context) async {
    try {
      // Mostrar indicador de progreso inicial
      showDialog(
        context: context,
        barrierDismissible: false,
        builder:
            (context) => _buildProgressDialog(
              context,
              'Preparando datos de reseñas...',
              0,
              1,
            ),
      );

      // Obtener todos los places existentes
      final placesSnapshot = await _firestore.collection('places').get();
      final List<String> placeIds =
          placesSnapshot.docs.map((doc) => doc.id).toList();

      if (placeIds.isEmpty) {
        if (context.mounted) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No hay lugares disponibles para añadir reseñas'),
              backgroundColor: Colors.red,
            ),
          );
        }
        return;
      }

      // Determinar cuántas reseñas agregar por lugar (2-4 reseñas)
      final Map<String, int> reviewsPerPlace = {};
      int totalReviews = 0;

      for (final placeId in placeIds) {
        final reviewCount = _random.nextInt(3) + 2; // 2-4 reseñas por lugar
        reviewsPerPlace[placeId] = reviewCount;
        totalReviews += reviewCount;
      }

      // Actualizar diálogo
      if (context.mounted) {
        Navigator.of(context).pop();
        showDialog(
          context: context,
          barrierDismissible: false,
          builder:
              (context) => _buildProgressDialog(
                context,
                'Generando reseñas...',
                0,
                totalReviews,
              ),
        );
      }

      // Generar y cargar las reseñas
      int reviewCount = 0;

      for (final entry in reviewsPerPlace.entries) {
        final placeId = entry.key;
        final count = entry.value;

        for (int i = 0; i < count; i++) {
          // Generar una reseña aleatoria
          final review = _generateRandomReview(placeId);

          // Agregar la reseña a Firestore
          final reviewRef = await _firestore.collection('reviews').add(review);

          // Actualizar el id en el documento
          await reviewRef.update({'id': reviewRef.id});

          // Actualizar el progreso
          reviewCount++;
          if (context.mounted) {
            Navigator.of(context).pop();
            if (reviewCount < totalReviews) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder:
                    (context) => _buildProgressDialog(
                      context,
                      'Cargando reseñas...',
                      reviewCount,
                      totalReviews,
                    ),
              );
            }
          }
        }
      }

      // Cerrar diálogo de progreso final
      if (context.mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Reseñas adicionales cargadas correctamente'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al cargar reseñas: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
      print('Error al cargar reseñas adicionales: $e');
    }
  }

  /// Genera una reseña aleatoria para un lugar
  Map<String, dynamic> _generateRandomReview(String placeId) {
    final userNames = [
      'Jose Carlos',
      'María Fernández',
      'Juan López',
      'Ana Torres',
      'Pedro González',
      'Carmen Rodríguez',
      'Miguel Díaz',
      'Laura Martínez',
      'Roberto Sánchez',
      'Sofía Gómez',
    ];

    final comments = [
      'Excelente comida y una vista impresionante de La Habana',
      'El mejor servicio que he recibido en un restaurante cubano',
      'Buena relación calidad-precio. Volvería sin duda',
      'Las bebidas estaban deliciosas y el ambiente muy agradable',
      'Atención impecable, aunque los precios son un poco elevados',
      'Un lugar perfecto para disfrutar de la gastronomía cubana',
      'Experiencia inolvidable, música en vivo y comida exquisita',
      'La decoración es auténtica y el servicio muy profesional',
      'El ambiente es acogedor y la comida típica muy sabrosa',
      'Increíble noche con la mejor música y cócteles de La Habana',
      'Los camarones al ajillo estaban espectaculares',
      'El arroz con frijoles y la ropa vieja son platos que no te puedes perder',
      'Un buen lugar para probar el auténtico mojito cubano',
      'Las vistas al mar desde la terraza son incomparables',
    ];

    final randomDate = DateTime.now().subtract(
      Duration(days: _random.nextInt(90)), // Dentro de los últimos 90 días
    );

    final userName = userNames[_random.nextInt(userNames.length)];
    final comment = comments[_random.nextInt(comments.length)];
    final rating =
        ((_random.nextInt(20) + 30) / 10).toDouble(); // Ratings entre 3.0 y 5.0

    return {
      'userName': userName,
      'userAvatar':
          'https://randomuser.me/api/portraits/${_random.nextBool() ? 'men' : 'women'}/${_random.nextInt(100)}.jpg',
      'comment': comment,
      'rating': rating,
      'date': Timestamp.fromDate(randomDate),
      'createdAt': Timestamp.fromDate(randomDate),
      'placeId': placeId,
    };
  }

  /// Construye un diálogo de progreso
  Widget _buildProgressDialog(
    BuildContext context,
    String title,
    int current,
    int total,
  ) {
    return AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LinearProgressIndicator(value: total > 0 ? current / total : 0),
          const SizedBox(height: 16),
          Text('$current de $total completados'),
        ],
      ),
    );
  }
}
