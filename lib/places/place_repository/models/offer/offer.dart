import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'offer.freezed.dart';
part 'offer.g.dart';

// Conversor personalizado para manejar tanto Timestamp como String para DateTime
class TimestampDateTimeConverter implements JsonConverter<DateTime, dynamic> {
  const TimestampDateTimeConverter();

  @override
  DateTime fromJson(dynamic value) {
    if (value is Timestamp) {
      return value.toDate();
    } else if (value is String) {
      return DateTime.parse(value);
    } else if (value is DateTime) {
      return value;
    }
    return DateTime.now();
  }

  @override
  dynamic toJson(DateTime dateTime) => dateTime.toIso8601String();
}

@Freezed()
sealed class Offer with _$Offer {
  const factory Offer({
    required String offerTitle,
    required String offerDescription,
    @TimestampDateTimeConverter() required DateTime offerValidUntil,
    double? offerPrice,
    String? offerConditions,
    String? offerImage,
    @Default('') String name,
    @Default('') String description,
    @Default('') String image,
  }) = _Offer;

  factory Offer.fromJson(Map<String, dynamic> json) => _$OfferFromJson(json);

  // Custom Conversor for Firestore
  factory Offer.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    DateTime validUntil;
    try {
      if (data['offerValidUntil'] is Timestamp) {
        validUntil = (data['offerValidUntil'] as Timestamp).toDate();
      } else if (data['offerValidUntil'] is String) {
        validUntil = DateTime.parse(data['offerValidUntil'] as String);
      } else {
        validUntil = DateTime.now().add(const Duration(days: 30));
      }
    } catch (e) {
      validUntil = DateTime.now().add(const Duration(days: 30));
    }

    return Offer(
      offerTitle: data['offerTitle'] ?? '',
      offerDescription: data['offerDescription'] ?? '',
      offerValidUntil: validUntil,
      offerPrice:
          data['offerPrice'] != null
              ? (data['offerPrice'] as num).toDouble()
              : 0,
      offerConditions: data['offerConditions'] ?? '',
      offerImage: data['offerImage'] ?? '',
      name: data['name'] ?? data['offerTitle'] ?? '',
      description: data['description'] ?? data['offerDescription'] ?? '',
      image: data['image'] ?? data['offerImage'] ?? '',
    );
  }
}
