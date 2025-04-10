import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:turbo/mock_data/mock_events.dart';
import '../interface/event_interface.dart';
import '../models/event.dart';

class EventService implements EventInterface {
  final FirebaseFirestore firestore;

  EventService({required this.firestore});

  @override
  Future<List<Event>> getEvents() async {
    try {
      final snapshot = await firestore.collection('events').get();
      if (snapshot.docs.isEmpty) {
        print('No hay eventos en Firestore, utilizando datos ficticios');
        return getMockEvents();
      }
      return snapshot.docs.map((doc) => Event.fromFirestore(doc)).toList();
    } catch (e) {
      print(
        'Error al obtener eventos de Firestore: $e, utilizando datos ficticios',
      );
      return getMockEvents();
    }
  }

  @override
  Future<List<Event>> getTodayEvents() async {
    try {
      final today = DateTime.now();
      final startOfDay = DateTime(today.year, today.month, today.day);
      final endOfDay = DateTime(today.year, today.month, today.day, 23, 59, 59);

      final snapshot =
          await firestore
              .collection('events')
              .where('date', isGreaterThanOrEqualTo: startOfDay)
              .where('date', isLessThanOrEqualTo: endOfDay)
              .get();

      if (snapshot.docs.isEmpty) {
        print(
          'No hay eventos para hoy en Firestore, utilizando datos ficticios',
        );
        // Filtrar solo eventos de hoy en los datos ficticios
        return getMockEvents();
      }

      return snapshot.docs.map((doc) => Event.fromFirestore(doc)).toList();
    } catch (e) {
      print('Error al obtener eventos de hoy: $e, utilizando datos ficticios');
      return getMockEvents();
    }
  }

  @override
  Future<List<Event>> getEventsByType(EventType type) async {
    try {
      final typeString = type.toString().split('.').last;
      final snapshot =
          await firestore
              .collection('events')
              .where('type', isEqualTo: typeString)
              .get();

      if (snapshot.docs.isEmpty) {
        // Filtrar sólo eventos del tipo especificado en los datos ficticios
        return getMockEvents().where((event) => event.type == type).toList();
      }

      return snapshot.docs.map((doc) => Event.fromFirestore(doc)).toList();
    } catch (e) {
      print(
        'Error al obtener eventos por tipo: $e, utilizando datos ficticios filtrados',
      );
      return getMockEvents().where((event) => event.type == type).toList();
    }
  }

  @override
  Future<Event> getEventById(String id) async {
    try {
      final doc = await firestore.collection('events').doc(id).get();
      if (!doc.exists) {
        // Buscar en datos ficticios
        final mockEvent = getMockEvents().firstWhere(
          (event) => event.id == id,
          orElse: () => throw Exception('Evento no encontrado'),
        );
        return mockEvent;
      }
      return Event.fromFirestore(doc);
    } catch (e) {
      // Intentar obtener de datos ficticios
      try {
        return getMockEvents().firstWhere((event) => event.id == id);
      } catch (_) {
        throw Exception('Error al obtener evento por ID: $e');
      }
    }
  }

  @override
  Future<List<Event>> getEventsByPlaceId(String placeId) async {
    try {
      final snapshot =
          await firestore
              .collection('events')
              .where('placeId', isEqualTo: placeId)
              .get();

      if (snapshot.docs.isEmpty) {
        // Filtrar sólo eventos del lugar especificado en los datos ficticios
        return getMockEvents()
            .where((event) => event.placeId == placeId)
            .toList();
      }

      return snapshot.docs.map((doc) => Event.fromFirestore(doc)).toList();
    } catch (e) {
      print(
        'Error al obtener eventos por lugar: $e, utilizando datos ficticios filtrados',
      );
      return getMockEvents()
          .where((event) => event.placeId == placeId)
          .toList();
    }
  }

  @override
  Future<List<Event>> getHighlightedEvents() async {
    try {
      final snapshot =
          await firestore
              .collection('events')
              .where('isHighlighted', isEqualTo: true)
              .get();

      if (snapshot.docs.isEmpty) {
        // Filtrar sólo eventos destacados en los datos ficticios
        return getMockEvents().where((event) => event.isHighlighted).toList();
      }

      return snapshot.docs.map((doc) => Event.fromFirestore(doc)).toList();
    } catch (e) {
      print(
        'Error al obtener eventos destacados: $e, utilizando datos ficticios filtrados',
      );
      return getMockEvents().where((event) => event.isHighlighted).toList();
    }
  }

  // Método para cargar datos ficticios en Firestore (útil para desarrollo)
  Future<void> loadMockDataToFirestore() async {
    await uploadMockEventsToFirestore(firestore);
  }
}
