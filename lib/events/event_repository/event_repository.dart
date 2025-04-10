import 'package:turbo/events/event_repository/models/event.dart';
import 'package:turbo/events/event_repository/service/event_service.dart';

// Interfaz para el repositorio de eventos
abstract class EventRepository {
  Future<List<Event>> getEvents();
  Future<List<Event>> getTodayEvents();
  Future<List<Event>> getEventsByType(EventType type);
  Future<Event> getEventById(String id);
  Future<List<Event>> getEventsByPlaceId(String placeId);
  Future<List<Event>> getHighlightedEvents();
}

// Implementación concreta del repositorio de eventos
class EventRepositoryImpl implements EventRepository {
  final EventService eventService;

  EventRepositoryImpl({required this.eventService});

  @override
  Future<List<Event>> getEvents() {
    return eventService.getEvents();
  }

  @override
  Future<List<Event>> getTodayEvents() {
    return eventService.getTodayEvents();
  }

  @override
  Future<List<Event>> getEventsByType(EventType type) {
    return eventService.getEventsByType(type);
  }

  @override
  Future<Event> getEventById(String id) {
    return eventService.getEventById(id);
  }

  @override
  Future<List<Event>> getEventsByPlaceId(String placeId) {
    return eventService.getEventsByPlaceId(placeId);
  }

  @override
  Future<List<Event>> getHighlightedEvents() {
    return eventService.getHighlightedEvents();
  }
}
