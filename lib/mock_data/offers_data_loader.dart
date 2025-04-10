import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:math';

/// Clase para cargar ofertas adicionales en lugares existentes
class OffersDataLoader {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Random _random = Random();

  /// Carga ofertas adicionales en Firestore para lugares existentes
  Future<void> loadAdditionalOffers(BuildContext context) async {
    try {
      // Mostrar indicador de progreso inicial
      showDialog(
        context: context,
        barrierDismissible: false,
        builder:
            (context) => _buildProgressDialog(
              context,
              'Preparando datos de ofertas...',
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
              content: Text('No hay lugares disponibles para añadir ofertas'),
              backgroundColor: Colors.red,
            ),
          );
        }
        return;
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
                'Cargando nuevas ofertas...',
                0,
                _additionalOffers.length,
              ),
        );
      }

      // Cargar las ofertas
      int offerCount = 0;

      for (final offer in _additionalOffers) {
        // Seleccionar un lugar aleatorio para esta oferta
        final randomPlaceId = placeIds[_random.nextInt(placeIds.length)];

        // Crear fecha de validez como Timestamp
        final validUntilDate = DateTime.now().add(
          Duration(days: 30 + _random.nextInt(60)),
        );

        // Crear el objeto de oferta
        final offerData = {
          ...offer,
          'placeId': randomPlaceId,
          'offerValidUntil': Timestamp.fromDate(validUntilDate),
        };

        // Agregar la oferta a Firestore
        final offerRef = await _firestore.collection('offers').add(offerData);

        // Actualizar el id en el documento
        await offerRef.update({'id': offerRef.id});

        // Actualizar el progreso
        offerCount++;
        if (context.mounted) {
          Navigator.of(context).pop();
          if (offerCount < _additionalOffers.length) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder:
                  (context) => _buildProgressDialog(
                    context,
                    'Cargando nuevas ofertas...',
                    offerCount,
                    _additionalOffers.length,
                  ),
            );
          }
        }
      }

      // Cerrar diálogo de progreso final
      if (context.mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Ofertas adicionales cargadas correctamente'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al cargar ofertas: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
      print('Error al cargar ofertas adicionales: $e');
    }
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

  // Lista de ofertas adicionales para añadir a los lugares
  final List<Map<String, dynamic>> _additionalOffers = [
    {
      'offerTitle': 'Happy hour: "Todos los tragos a mitad de precio"',
      'offerDescription':
          'Los clientes que ordenen cualquier tipo de tragos van a tner un descuento del 50%',
      'offerPrice': 250.0,
      'offerConditions': 'No se aceptan menores de 18 años',
      'offerImage':
          'https://images.unsplash.com/photo-1551024709-8f23befc6f87?q=80&w=1000',
      'name': 'Happy hour: "Todos los tragos a mitad de precio"',
      'description': 'Promoción especial de bebidas',
      'image':
          'https://images.unsplash.com/photo-1551024709-8f23befc6f87?q=80&w=1000',
    },
    {
      'offerTitle': 'Menú degustación cubano',
      'offerDescription':
          'Prueba los mejores platos de la cocina cubana con nuestro menú degustación de 5 tiempos',
      'offerPrice': 350.0,
      'offerConditions': 'Mínimo 2 personas. Reserva con 24h de antelación',
      'offerImage':
          'https://images.unsplash.com/photo-1544025162-d76694265947?q=80&w=1000',
      'name': 'Menú degustación cubano',
      'description': 'Un viaje por la gastronomía cubana',
      'image':
          'https://images.unsplash.com/photo-1544025162-d76694265947?q=80&w=1000',
    },
    {
      'offerTitle': 'Café y postre cubano',
      'offerDescription':
          'Disfruta de un auténtico café cubano acompañado de nuestro postre del día',
      'offerPrice': 85.0,
      'offerConditions': 'Disponible todos los días de 15:00 a 18:00',
      'offerImage':
          'https://images.unsplash.com/photo-1509042239860-f550ce710b93?q=80&w=1000',
      'name': 'Café y postre cubano',
      'description': 'El dulce sabor de Cuba',
      'image':
          'https://images.unsplash.com/photo-1509042239860-f550ce710b93?q=80&w=1000',
    },
    {
      'offerTitle': 'Noche de salsa',
      'offerDescription':
          'Entrada gratuita a nuestra noche de salsa con banda en vivo y una bebida de cortesía',
      'offerPrice': 120.0,
      'offerConditions': 'Todos los jueves a partir de las 21:00',
      'offerImage':
          'https://images.unsplash.com/photo-1504609813442-a9924e2e4290?q=80&w=1000',
      'name': 'Noche de salsa',
      'description': 'El mejor ritmo cubano',
      'image':
          'https://images.unsplash.com/photo-1504609813442-a9924e2e4290?q=80&w=1000',
    },
    {
      'offerTitle': 'Especial de mariscos',
      'offerDescription':
          'Plato especial de mariscos frescos del día con guarnición y copa de vino blanco',
      'offerPrice': 380.0,
      'offerConditions': 'Sujeto a disponibilidad del pescado del día',
      'offerImage':
          'https://images.unsplash.com/photo-1532347922424-c84d04eba9b3?q=80&w=1000',
      'name': 'Especial de mariscos',
      'description': 'El mejor sabor del mar',
      'image':
          'https://images.unsplash.com/photo-1532347922424-c84d04eba9b3?q=80&w=1000',
    },
  ];
}
