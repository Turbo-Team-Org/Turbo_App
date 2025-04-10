import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event.freezed.dart';
part 'event.g.dart';

enum EventType { party, concert, promotion, offer, cultural }

@freezed
sealed class Event with _$Event {
  const factory Event({
    required String id,
    required String title,
    required String description,
    required DateTime date,
    required String location,
    required String imageUrl,
    required EventType type,
    String? placeId,
    double? price,
    @Default(false) bool isHighlighted,
    @Default([]) List<String> tags,
    String? organizerName,
    String? organizerContact,
    DateTime? endDate,
    String? link,
  }) = _Event;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  factory Event.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Event(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      date: (data['date'] as Timestamp).toDate(),
      location: data['location'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      type: _parseEventType(data['type'] ?? 'offer'),
      placeId: data['placeId'],
      price: (data['price'] as num?)?.toDouble(),
      isHighlighted: data['isHighlighted'] ?? false,
      tags: List<String>.from(data['tags'] ?? []),
      organizerName: data['organizerName'],
      organizerContact: data['organizerContact'],
      endDate:
          data['endDate'] != null
              ? (data['endDate'] as Timestamp).toDate()
              : null,
      link: data['link'],
    );
  }
}

EventType _parseEventType(String type) {
  switch (type.toLowerCase()) {
    case 'party':
      return EventType.party;
    case 'concert':
      return EventType.concert;
    case 'promotion':
      return EventType.promotion;
    case 'cultural':
      return EventType.cultural;
    case 'offer':
    default:
      return EventType.offer;
  }
}
