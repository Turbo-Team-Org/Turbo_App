import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'review.freezed.dart';
part 'review.g.dart';

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
sealed class Review with _$Review {
  const factory Review({
    required String id,
    required String userName,
    required String userAvatar,
    required String comment,
    required double rating,
    @TimestampDateTimeConverter() required DateTime date,
    @TimestampDateTimeConverter() DateTime? createdAt,
  }) = _Review;

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  factory Review.fromFirestore(Map<String, dynamic> data) {
    DateTime parsedDate;
    try {
      if (data['date'] is Timestamp) {
        parsedDate = (data['date'] as Timestamp).toDate();
      } else if (data['date'] is String) {
        parsedDate = DateTime.parse(data['date'] as String);
      } else {
        parsedDate = DateTime.now();
      }
    } catch (e) {
      parsedDate = DateTime.now();
    }

    DateTime? createdAt;
    try {
      if (data['createdAt'] is Timestamp) {
        createdAt = (data['createdAt'] as Timestamp).toDate();
      } else if (data['createdAt'] is String) {
        createdAt = DateTime.parse(data['createdAt'] as String);
      }
    } catch (e) {
      createdAt = parsedDate;
    }

    return Review(
      id: data['id'] ?? '',
      userName: data['userName'] ?? '',
      userAvatar: data['userAvatar'] ?? '',
      comment: data['comment'] ?? '',
      rating:
          (data['rating'] != null) ? (data['rating'] as num).toDouble() : 0.0,
      date: parsedDate,
      createdAt: createdAt ?? parsedDate,
    );
  }
}
