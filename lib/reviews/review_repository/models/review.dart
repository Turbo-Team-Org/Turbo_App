import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'review.freezed.dart';
part 'review.g.dart';

@Freezed()
sealed class Review with _$Review {
  const factory Review({
    required String id,
    required String userName,
    required String userAvatar,
    required String comment,
    required double rating,
    required DateTime date,
    DateTime? createdAt,
  }) = _Review;

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  factory Review.fromFirestore(Map<String, dynamic> data) {
    DateTime parsedDate;
    try {
      parsedDate = (data['date'] as Timestamp).toDate();
    } catch (e) {
      parsedDate = DateTime.now();
    }

    return Review(
      id: data['id'] ?? '',
      userName: data['userName'] ?? '',
      userAvatar: data['userAvatar'] ?? '',
      comment: data['comment'] ?? '',
      rating:
          (data['rating'] != null) ? (data['rating'] as num).toDouble() : 0.0,
      date: parsedDate,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? parsedDate,
    );
  }
}
