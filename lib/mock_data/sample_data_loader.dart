import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:math';

/// Clase para cargar datos de prueba en Firestore
class SampleDataLoader {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Random _random = Random();

  /// Carga los datos de muestra en Firestore
  Future<void> loadSamplePlaces(BuildContext context) async {
    try {
      // Mostrar indicador de progreso inicial
      showDialog(
        context: context,
        barrierDismissible: false,
        builder:
            (context) =>
                _buildProgressDialog(context, 'Preparando datos...', 0, 1),
      );

      // Cargamos los datos directamente sin eliminar las colecciones existentes
      final placeIds = await _loadPlaces(context);
      await _loadOffers(context, placeIds);
      await _loadReviews(context, placeIds);

      // Cerrar diálogo de progreso final
      if (context.mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Datos de prueba cargados correctamente'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al cargar datos: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
      print('Error al cargar datos de prueba: $e');
    }
  }

  /// Carga los lugares en Firestore
  Future<List<String>> _loadPlaces(BuildContext context) async {
    final placesCollection = _firestore.collection('places');
    final placeIds = <String>[];

    if (context.mounted) {
      Navigator.of(context).pop();
      showDialog(
        context: context,
        barrierDismissible: false,
        builder:
            (context) => _buildProgressDialog(
              context,
              'Cargando lugares...',
              0,
              _cubanPlaces.length,
            ),
      );
    }

    int count = 0;
    for (final place in _cubanPlaces) {
      // Crear una copia del lugar sin las ofertas ni reviews
      final placeData = Map<String, dynamic>.from(place);

      // Eliminar las referencias a otras colecciones
      placeData.remove('reviews');
      placeData.remove('offers');

      // Agregar el lugar a Firestore
      final docRef = await placesCollection.add(placeData);
      final placeId = docRef.id;

      // Actualizar el id en el documento
      await docRef.update({'id': placeId});
      placeIds.add(placeId);

      // Actualizar el progreso
      count++;
      if (context.mounted) {
        Navigator.of(context).pop();
        if (count < _cubanPlaces.length) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder:
                (context) => _buildProgressDialog(
                  context,
                  'Cargando lugares...',
                  count,
                  _cubanPlaces.length,
                ),
          );
        }
      }
    }

    return placeIds;
  }

  /// Carga las ofertas en Firestore
  Future<void> _loadOffers(BuildContext context, List<String> placeIds) async {
    if (placeIds.isEmpty) return;

    final offersCollection = _firestore.collection('offers');
    int offerCount = 0;
    final totalOffers = _cubanPlaces.fold<int>(
      0,
      (sum, place) => sum + (place['offers'] as List).length,
    );

    if (context.mounted) {
      Navigator.of(context).pop();
      showDialog(
        context: context,
        barrierDismissible: false,
        builder:
            (context) => _buildProgressDialog(
              context,
              'Cargando ofertas...',
              0,
              totalOffers,
            ),
      );
    }

    for (int i = 0; i < _cubanPlaces.length; i++) {
      final placeId = placeIds[i];
      final offers = _cubanPlaces[i]['offers'] as List;

      for (final offerData in offers) {
        final offer = Map<String, dynamic>.from(
          offerData as Map<String, dynamic>,
        );

        // Agregar el ID del lugar como referencia
        offer['placeId'] = placeId;

        // Agregar la oferta a Firestore
        final offerRef = await offersCollection.add(offer);

        // Actualizar el id de la oferta
        await offerRef.update({'id': offerRef.id});

        // Actualizar el progreso
        offerCount++;
        if (context.mounted) {
          Navigator.of(context).pop();
          if (offerCount < totalOffers) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder:
                  (context) => _buildProgressDialog(
                    context,
                    'Cargando ofertas...',
                    offerCount,
                    totalOffers,
                  ),
            );
          }
        }
      }
    }
  }

  /// Carga las reviews en Firestore
  Future<void> _loadReviews(BuildContext context, List<String> placeIds) async {
    if (placeIds.isEmpty) return;

    final reviewsCollection = _firestore.collection('reviews');
    // Asignar 2-4 reviews por lugar
    int totalReviews = 0;

    // Crear mapa de lugar a reviews
    final Map<String, List<Map<String, dynamic>>> placeReviews = {};

    for (final placeId in placeIds) {
      final reviewCount = _random.nextInt(3) + 2; // 2-4 reviews por lugar
      totalReviews += reviewCount;

      placeReviews[placeId] = List.generate(
        reviewCount,
        (index) => _generateRandomReview(placeId),
      );
    }

    if (context.mounted) {
      Navigator.of(context).pop();
      showDialog(
        context: context,
        barrierDismissible: false,
        builder:
            (context) => _buildProgressDialog(
              context,
              'Cargando reseñas...',
              0,
              totalReviews,
            ),
      );
    }

    int reviewCount = 0;
    for (final entry in placeReviews.entries) {
      final reviews = entry.value;

      for (final review in reviews) {
        // Agregar la reseña a Firestore
        final reviewRef = await reviewsCollection.add(review);

        // Actualizar el id de la reseña
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
  }

  /// Genera una reseña aleatoria para un lugar
  Map<String, dynamic> _generateRandomReview(String placeId) {
    final userNames = [
      'Carlos Rodríguez',
      'María Pérez',
      'Juan García',
      'Ana Martínez',
      'Luis González',
      'Laura Fernández',
      'Pedro Díaz',
      'Carmen López',
      'José Sánchez',
      'Elena Ramírez',
    ];

    final comments = [
      'Excelente servicio y ambiente.',
      'La comida estaba deliciosa. Muy recomendable.',
      'Buena relación calidad-precio.',
      'Me encantó el lugar, volveré pronto.',
      'Atención impecable, aunque un poco caro.',
      'Buen lugar para visitar en familia.',
      'Experiencia agradable, aunque esperaba más.',
      'Muy auténtico y con excelente calidad.',
      'El ambiente es fenomenal, buena música.',
      'Atención rápida y profesional.',
      'Precios razonables para la calidad que ofrecen.',
      'Una vista impresionante y buena comida.',
      'Un poco decepcionante, esperaba más por las reseñas.',
      'Definitivamente volveré, me encantó todo.',
    ];

    final randomDate = DateTime.now().subtract(
      Duration(days: _random.nextInt(60)), // Dentro de los últimos 60 días
    );

    final userName = userNames[_random.nextInt(userNames.length)];
    final comment = comments[_random.nextInt(comments.length)];
    final rating = (_random.nextInt(15) + 30) / 10; // Ratings entre 3.0 y 4.5

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

  // Lista de datos de lugares para Cuba (se añadirán posteriormente)
  final List<Map<String, dynamic>> _cubanPlaces = [
    {
      'name': 'La Bodeguita del Medio',
      'description':
          'Icónico restaurante y bar en La Habana Vieja, famoso por su mojito y por ser uno de los lugares preferidos de Ernest Hemingway. Ofrece auténtica comida cubana con música tradicional en vivo.',
      'address': 'Empedrado 207, La Habana Vieja, La Habana',
      'averagePrice': 15.50,
      'imageUrls': [
        'https://images.unsplash.com/photo-1584055482118-3f355578daef?q=80&w=1000',
        'https://images.unsplash.com/photo-1568495720707-dba5da17bc5c?q=80&w=1000',
        'https://images.unsplash.com/photo-1563293740-7828d95648db?q=80&w=1000',
      ],
      'rating': 4.7,
      'tags': ['Restaurante', 'Bar', 'Música en vivo', 'Histórico'],
      'isOpen': true,
      'schedules': [
        {
          'opening': '10:00',
          'closing': '00:00',
          'isFullDay': false,
          'dayName': 'Lunes',
        },
        {
          'opening': '10:00',
          'closing': '00:00',
          'isFullDay': false,
          'dayName': 'Martes',
        },
        {
          'opening': '10:00',
          'closing': '00:00',
          'isFullDay': false,
          'dayName': 'Miércoles',
        },
        {
          'opening': '10:00',
          'closing': '01:00',
          'isFullDay': false,
          'dayName': 'Jueves',
        },
        {
          'opening': '10:00',
          'closing': '02:00',
          'isFullDay': false,
          'dayName': 'Viernes',
        },
        {
          'opening': '10:00',
          'closing': '02:00',
          'isFullDay': false,
          'dayName': 'Sábado',
        },
        {
          'opening': '10:00',
          'closing': '00:00',
          'isFullDay': false,
          'dayName': 'Domingo',
        },
      ],
      'mainImage':
          'https://images.unsplash.com/photo-1584055482118-3f355578daef?q=80&w=1000',
      'favoriteCount': 156,
      'offers': [
        {
          'offerTitle': 'Mojito + Tapa Cubana',
          'offerDescription':
              'Disfruta del auténtico mojito de La Bodeguita con una tapa de ropa vieja por un precio especial',
          'offerValidUntil': Timestamp.fromDate(
            DateTime.now().add(const Duration(days: 30)),
          ),
          'offerPrice': 12.00,
          'offerConditions': 'Válido todos los días de 15:00 a 18:00',
          'offerImage':
              'https://images.unsplash.com/photo-1563293740-7828d95648db?q=80&w=1000',
          'name': 'Mojito + Tapa Cubana',
          'description': 'La mejor experiencia cubana',
          'image':
              'https://images.unsplash.com/photo-1563293740-7828d95648db?q=80&w=1000',
        },
      ],
    },
    {
      'name': 'Floridita',
      'description':
          'Legendario bar restaurante reconocido como "La cuna del Daiquiri" y otro de los favoritos de Hemingway. Ofrece mariscos, cócteles y música tradicional en un ambiente elegante con historia.',
      'address': 'Obispo 557, La Habana Vieja, La Habana',
      'averagePrice': 25.00,
      'imageUrls': [
        'https://images.unsplash.com/photo-1571805341302-f857308690e3?q=80&w=1000',
        'https://images.unsplash.com/photo-1623873217983-1c70b0ef9536?q=80&w=1000',
        'https://images.unsplash.com/photo-1589304038421-449708a42983?q=80&w=1000',
      ],
      'rating': 4.8,
      'tags': ['Restaurante', 'Bar', 'Mariscos', 'Cócteles', 'Histórico'],
      'isOpen': true,
      'schedules': [
        {
          'opening': '11:00',
          'closing': '23:30',
          'isFullDay': false,
          'dayName': 'Lunes',
        },
        {
          'opening': '11:00',
          'closing': '23:30',
          'isFullDay': false,
          'dayName': 'Martes',
        },
        {
          'opening': '11:00',
          'closing': '23:30',
          'isFullDay': false,
          'dayName': 'Miércoles',
        },
        {
          'opening': '11:00',
          'closing': '23:30',
          'isFullDay': false,
          'dayName': 'Jueves',
        },
        {
          'opening': '11:00',
          'closing': '00:30',
          'isFullDay': false,
          'dayName': 'Viernes',
        },
        {
          'opening': '11:00',
          'closing': '00:30',
          'isFullDay': false,
          'dayName': 'Sábado',
        },
        {
          'opening': '11:00',
          'closing': '23:00',
          'isFullDay': false,
          'dayName': 'Domingo',
        },
      ],
      'mainImage':
          'https://images.unsplash.com/photo-1571805341302-f857308690e3?q=80&w=1000',
      'favoriteCount': 201,
      'offers': [
        {
          'offerTitle': 'Daiquiri Hemingway',
          'offerDescription':
              'Prueba nuestro Daiquiri especial preparado según la receta preferida de Ernest Hemingway',
          'offerValidUntil': Timestamp.fromDate(
            DateTime.now().add(const Duration(days: 45)),
          ),
          'offerPrice': 9.50,
          'offerConditions': 'Limitado a dos por persona',
          'offerImage':
              'https://images.unsplash.com/photo-1623873217983-1c70b0ef9536?q=80&w=1000',
          'name': 'Daiquiri Hemingway',
          'description': 'El cóctel más famoso de Cuba',
          'image':
              'https://images.unsplash.com/photo-1623873217983-1c70b0ef9536?q=80&w=1000',
        },
      ],
    },
    {
      'name': 'Paladar Los Amigos',
      'description':
          'Auténtico paladar cubano situado en una casa colonial restaurada en Trinidad. Ofrece deliciosa comida casera cubana con ingredientes frescos locales en un ambiente familiar.',
      'address': 'Calle Jesús Menéndez 122, Trinidad, Sancti Spíritus',
      'averagePrice': 12.00,
      'imageUrls': [
        'https://images.unsplash.com/photo-1554321585-ef3ce9d3d140?q=80&w=1000',
        'https://images.unsplash.com/photo-1507236827745-0196b89fb749?q=80&w=1000',
        'https://images.unsplash.com/photo-1535141192574-5d4897c12636?q=80&w=1000',
      ],
      'rating': 4.6,
      'tags': ['Paladar', 'Comida casera', 'Auténtico', 'Económico'],
      'isOpen': true,
      'schedules': [
        {
          'opening': '12:00',
          'closing': '22:00',
          'isFullDay': false,
          'dayName': 'Lunes',
        },
        {
          'opening': '12:00',
          'closing': '22:00',
          'isFullDay': false,
          'dayName': 'Martes',
        },
        {
          'opening': '12:00',
          'closing': '22:00',
          'isFullDay': false,
          'dayName': 'Miércoles',
        },
        {
          'opening': '12:00',
          'closing': '22:00',
          'isFullDay': false,
          'dayName': 'Jueves',
        },
        {
          'opening': '12:00',
          'closing': '23:00',
          'isFullDay': false,
          'dayName': 'Viernes',
        },
        {
          'opening': '12:00',
          'closing': '23:00',
          'isFullDay': false,
          'dayName': 'Sábado',
        },
        {
          'opening': '12:00',
          'closing': '21:00',
          'isFullDay': false,
          'dayName': 'Domingo',
        },
      ],
      'mainImage':
          'https://images.unsplash.com/photo-1554321585-ef3ce9d3d140?q=80&w=1000',
      'favoriteCount': 89,
      'offers': [
        {
          'offerTitle': 'Menú Completo Cubano',
          'offerDescription':
              'Menú degustación con platos tradicionales: ropa vieja, congrí, tostones y postre casero',
          'offerValidUntil': Timestamp.fromDate(
            DateTime.now().add(const Duration(days: 60)),
          ),
          'offerPrice': 15.00,
          'offerConditions': 'Mínimo 2 personas',
          'offerImage':
              'https://images.unsplash.com/photo-1535141192574-5d4897c12636?q=80&w=1000',
          'name': 'Menú Completo Cubano',
          'description': 'La auténtica experiencia cubana',
          'image':
              'https://images.unsplash.com/photo-1535141192574-5d4897c12636?q=80&w=1000',
        },
      ],
    },
    {
      'name': 'Café Habana',
      'description':
          'Cafetería tradicional en el corazón de La Habana que sirve el auténtico café cubano junto con dulces tradicionales. Ambiente nostálgico con decoración vintage de los años 50.',
      'address': 'Calle O\'Reilly 316, La Habana Vieja, La Habana',
      'averagePrice': 5.00,
      'imageUrls': [
        'https://images.unsplash.com/photo-1559925393-8be0ec4767c8?q=80&w=1000',
        'https://images.unsplash.com/photo-1442512595331-e89e73853f31?q=80&w=1000',
        'https://images.unsplash.com/photo-1600093463592-8e36ae95ef56?q=80&w=1000',
      ],
      'rating': 4.5,
      'tags': ['Café', 'Desayuno', 'Dulces', 'Vintage'],
      'isOpen': true,
      'schedules': [
        {
          'opening': '07:00',
          'closing': '20:00',
          'isFullDay': false,
          'dayName': 'Lunes',
        },
        {
          'opening': '07:00',
          'closing': '20:00',
          'isFullDay': false,
          'dayName': 'Martes',
        },
        {
          'opening': '07:00',
          'closing': '20:00',
          'isFullDay': false,
          'dayName': 'Miércoles',
        },
        {
          'opening': '07:00',
          'closing': '20:00',
          'isFullDay': false,
          'dayName': 'Jueves',
        },
        {
          'opening': '07:00',
          'closing': '21:00',
          'isFullDay': false,
          'dayName': 'Viernes',
        },
        {
          'opening': '08:00',
          'closing': '21:00',
          'isFullDay': false,
          'dayName': 'Sábado',
        },
        {
          'opening': '08:00',
          'closing': '19:00',
          'isFullDay': false,
          'dayName': 'Domingo',
        },
      ],
      'mainImage':
          'https://images.unsplash.com/photo-1559925393-8be0ec4767c8?q=80&w=1000',
      'favoriteCount': 76,
      'offers': [
        {
          'offerTitle': 'Desayuno Cubano',
          'offerDescription':
              'Café cubano, jugo de guayaba natural y tostada con mantequilla',
          'offerValidUntil': Timestamp.fromDate(
            DateTime.now().add(const Duration(days: 30)),
          ),
          'offerPrice': 4.50,
          'offerConditions': 'Disponible hasta las 11:00',
          'offerImage':
              'https://images.unsplash.com/photo-1600093463592-8e36ae95ef56?q=80&w=1000',
          'name': 'Desayuno Cubano',
          'description': 'El mejor inicio del día',
          'image':
              'https://images.unsplash.com/photo-1600093463592-8e36ae95ef56?q=80&w=1000',
        },
      ],
    },
    {
      'name': 'La Guarida',
      'description':
          'Elegante paladar ubicado en una mansión histórica de Centro Habana, reconocido internacionalmente por su gastronomía creativa cubana y su atmósfera única. Escenario de la película "Fresa y Chocolate".',
      'address': 'Concordia 418, Centro Habana, La Habana',
      'averagePrice': 35.00,
      'imageUrls': [
        'https://images.unsplash.com/photo-1483137140003-ae073b395549?q=80&w=1000',
        'https://images.unsplash.com/photo-1482049016688-2d3e1b311543?q=80&w=1000',
        'https://images.unsplash.com/photo-1504674900247-0877df9cc836?q=80&w=1000',
      ],
      'rating': 4.9,
      'tags': ['Paladar', 'Gourmet', 'Romántico', 'Histórico'],
      'isOpen': true,
      'schedules': [
        {
          'opening': '12:00',
          'closing': '00:00',
          'isFullDay': false,
          'dayName': 'Lunes',
        },
        {
          'opening': '12:00',
          'closing': '00:00',
          'isFullDay': false,
          'dayName': 'Martes',
        },
        {
          'opening': '12:00',
          'closing': '00:00',
          'isFullDay': false,
          'dayName': 'Miércoles',
        },
        {
          'opening': '12:00',
          'closing': '00:00',
          'isFullDay': false,
          'dayName': 'Jueves',
        },
        {
          'opening': '12:00',
          'closing': '01:00',
          'isFullDay': false,
          'dayName': 'Viernes',
        },
        {
          'opening': '12:00',
          'closing': '01:00',
          'isFullDay': false,
          'dayName': 'Sábado',
        },
        {
          'opening': '12:00',
          'closing': '23:00',
          'isFullDay': false,
          'dayName': 'Domingo',
        },
      ],
      'mainImage':
          'https://images.unsplash.com/photo-1483137140003-ae073b395549?q=80&w=1000',
      'favoriteCount': 214,
      'offers': [
        {
          'offerTitle': 'Degustación Premium',
          'offerDescription':
              'Menú degustación de 5 tiempos con maridaje de vinos y rones seleccionados',
          'offerValidUntil': Timestamp.fromDate(
            DateTime.now().add(const Duration(days: 90)),
          ),
          'offerPrice': 55.00,
          'offerConditions': 'Reserva previa obligatoria. Mínimo 2 personas.',
          'offerImage':
              'https://images.unsplash.com/photo-1504674900247-0877df9cc836?q=80&w=1000',
          'name': 'Degustación Premium',
          'description': 'La alta cocina cubana',
          'image':
              'https://images.unsplash.com/photo-1504674900247-0877df9cc836?q=80&w=1000',
        },
      ],
    },
    {
      'name': 'Terraza del Malecón',
      'description':
          'Bar terraza con impresionantes vistas al Malecón habanero. Especializado en cócteles tropicales, música en vivo y puestas de sol inolvidables frente al mar.',
      'address': 'Malecón y Paseo de Martí, Centro Habana, La Habana',
      'averagePrice': 10.00,
      'imageUrls': [
        'https://images.unsplash.com/photo-1555921015-5ab9267699cd?q=80&w=1000',
        'https://images.unsplash.com/photo-1642213731873-3e37c6f58652?q=80&w=1000',
        'https://images.unsplash.com/photo-1496318447583-f524534e9ce1?q=80&w=1000',
      ],
      'rating': 4.7,
      'tags': ['Bar', 'Terraza', 'Vista al mar', 'Música en vivo', 'Cócteles'],
      'isOpen': true,
      'schedules': [
        {
          'opening': '16:00',
          'closing': '02:00',
          'isFullDay': false,
          'dayName': 'Lunes',
        },
        {
          'opening': '16:00',
          'closing': '02:00',
          'isFullDay': false,
          'dayName': 'Martes',
        },
        {
          'opening': '16:00',
          'closing': '02:00',
          'isFullDay': false,
          'dayName': 'Miércoles',
        },
        {
          'opening': '16:00',
          'closing': '03:00',
          'isFullDay': false,
          'dayName': 'Jueves',
        },
        {
          'opening': '16:00',
          'closing': '04:00',
          'isFullDay': false,
          'dayName': 'Viernes',
        },
        {
          'opening': '16:00',
          'closing': '04:00',
          'isFullDay': false,
          'dayName': 'Sábado',
        },
        {
          'opening': '16:00',
          'closing': '01:00',
          'isFullDay': false,
          'dayName': 'Domingo',
        },
      ],
      'mainImage':
          'https://images.unsplash.com/photo-1555921015-5ab9267699cd?q=80&w=1000',
      'favoriteCount': 167,
      'offers': [
        {
          'offerTitle': 'Happy Hour Tropical',
          'offerDescription':
              '2x1 en cócteles de ron durante la puesta del sol',
          'offerValidUntil': Timestamp.fromDate(
            DateTime.now().add(const Duration(days: 30)),
          ),
          'offerPrice': 8.00,
          'offerConditions': 'Válido de 17:00 a 19:00 todos los días',
          'offerImage':
              'https://images.unsplash.com/photo-1496318447583-f524534e9ce1?q=80&w=1000',
          'name': 'Happy Hour Tropical',
          'description': 'Disfruta del atardecer',
          'image':
              'https://images.unsplash.com/photo-1496318447583-f524534e9ce1?q=80&w=1000',
        },
      ],
    },
  ];
}
