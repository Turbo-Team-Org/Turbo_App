import '../models/event.dart';

abstract class EventInterface {
  Future<List<Event>> getEvents();
  Future<List<Event>> getTodayEvents();
  Future<List<Event>> getEventsByType(EventType type);
  Future<Event> getEventById(String id);
  Future<List<Event>> getEventsByPlaceId(String placeId);
  Future<List<Event>> getHighlightedEvents();
}
