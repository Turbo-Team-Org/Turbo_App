import 'package:turbo/events/event_repository/models/event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Datos de eventos ficticios para usar cuando no hay datos disponibles en Firestore
List<Event> getMockEvents() {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);

  return [
    Event(
      id: "event001",
      title: "Noche de Salsa en Casa de la Música",
      description:
          "Disfruta de una noche mágica con los mejores exponentes de la salsa cubana y shows en vivo.",
      date: today.add(const Duration(hours: 21)),
      location: "Calle Galiano, La Habana",
      imageUrl:
          "https://images.unsplash.com/photo-1504609813442-a8924e83f76e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1000&q=80",
      type: EventType.party,
      placeId: "1",
      price: 15.0,
      isHighlighted: true,
      tags: ["música", "baile", "cultural"],
      organizerName: "Casa de la Música",
      organizerContact: "+53 7862 4321",
    ),
    Event(
      id: "event002",
      title: "Festival Gastronómico Varadero",
      description:
          "Evento culinario que reúne a los mejores restaurantes de la zona con descuentos especiales y degustaciones.",
      date: today.add(const Duration(hours: 12)),
      location: "Playa de Varadero",
      imageUrl:
          "https://images.unsplash.com/photo-1555939594-58d7cb561ad1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1000&q=80",
      type: EventType.promotion,
      placeId: "2",
      price: 25.0,
      isHighlighted: true,
      tags: ["gastronomía", "playa", "descuentos"],
      organizerName: "Asociación de Restaurantes de Varadero",
      organizerContact: "+53 4567 8900",
    ),
    Event(
      id: "event003",
      title: "2x1 en Cócteles Tradicionales",
      description:
          "Promoción especial en todos los cócteles tradicionales cubanos durante todo el día.",
      date: today.add(const Duration(hours: 18)),
      location: "El Floridita, La Habana Vieja",
      imageUrl:
          "https://images.unsplash.com/photo-1551024709-8f23befc6f87?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1000&q=80",
      type: EventType.offer,
      placeId: "3",
      price: 8.0,
      tags: ["bebidas", "centro histórico", "oferta"],
      organizerName: "El Floridita",
    ),
    Event(
      id: "event004",
      title: "Visita Guiada al Museo de la Revolución",
      description:
          "Recorrido especial con guía experto que incluye acceso a exhibiciones exclusivas no disponibles normalmente.",
      date: today.add(const Duration(hours: 10)),
      location: "Museo de la Revolución, La Habana",
      imageUrl:
          "https://images.unsplash.com/photo-1569683795645-b62e50fbf103?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1000&q=80",
      type: EventType.cultural,
      placeId: "4",
      price: 5.0,
      tags: ["historia", "cultura", "museo"],
      organizerName: "Ministerio de Cultura",
      organizerContact: "+53 7862 1234",
    ),
    Event(
      id: "event005",
      title: "Concierto de Jazz en la Plaza",
      description:
          "Presentación de músicos de jazz locales e internacionales en un ambiente único al aire libre.",
      date: today.add(const Duration(hours: 19, minutes: 30)),
      location: "Plaza Vieja, La Habana",
      imageUrl:
          "https://images.unsplash.com/photo-1514525253161-7a46d19cd819?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1000&q=80",
      type: EventType.concert,
      placeId: "5",
      price: 10.0,
      isHighlighted: true,
      tags: ["música", "jazz", "aire libre"],
      organizerName: "Asociación Cubana de Jazz",
      organizerContact: "+53 7862 5678",
      link: "https://jazzplaza.cu",
    ),
  ];
}

// Función para simular la creación de eventos en Firestore
Future<void> uploadMockEventsToFirestore(FirebaseFirestore firestore) async {
  try {
    final batch = firestore.batch();
    final eventsCollection = firestore.collection('events');

    // Limpiar eventos existentes
    final existingEvents = await eventsCollection.get();
    for (var doc in existingEvents.docs) {
      batch.delete(doc.reference);
    }

    // Crear nuevos eventos ficticios
    for (var event in getMockEvents()) {
      final docRef = eventsCollection.doc(event.id);
      batch.set(docRef, {
        'title': event.title,
        'description': event.description,
        'date': Timestamp.fromDate(event.date),
        'location': event.location,
        'imageUrl': event.imageUrl,
        'type': event.type.toString().split('.').last,
        'placeId': event.placeId,
        'price': event.price,
        'isHighlighted': event.isHighlighted,
        'tags': event.tags,
        'organizerName': event.organizerName,
        'organizerContact': event.organizerContact,
        'link': event.link,
        'endDate':
            event.endDate != null ? Timestamp.fromDate(event.endDate!) : null,
      });
    }

    await batch.commit();
    print('Eventos ficticios cargados exitosamente en Firestore');
  } catch (e) {
    print('Error al cargar eventos ficticios en Firestore: $e');
  }
}
