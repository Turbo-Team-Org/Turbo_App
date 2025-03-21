// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Review _$ReviewFromJson(Map<String, dynamic> json) => _Review(
  id: json['id'] as String,
  userName: json['userName'] as String,
  userAvatar: json['userAvatar'] as String,
  comment: json['comment'] as String,
  rating: (json['rating'] as num).toDouble(),
  date: DateTime.parse(json['date'] as String),
  createdAt:
      json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$ReviewToJson(_Review instance) => <String, dynamic>{
  'id': instance.id,
  'userName': instance.userName,
  'userAvatar': instance.userAvatar,
  'comment': instance.comment,
  'rating': instance.rating,
  'date': instance.date.toIso8601String(),
  'createdAt': instance.createdAt?.toIso8601String(),
};
