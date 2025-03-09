import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'review.freezed.dart';
part 'review.g.dart';

@Freezed()
sealed class Review with _$Review {
  const factory Review({
    required int id,
    required String userName,
    required String userAvatar,
    required String comment,
    required double rating,
    required DateTime date,
  }) = _Review;

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  factory Review.fromFirestore(Map<String, dynamic> data) {
    return Review(
      id: data['id'],
      userName: data['userName'],
      userAvatar: data['userAvatar'],
      comment: data['comment'],
      rating: (data['rating'] as num).toDouble(),
      date: (data['date'] as Timestamp).toDate(),
    );
  }
}
