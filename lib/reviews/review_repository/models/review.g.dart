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
  date: const TimestampDateTimeConverter().fromJson(json['date']),
  createdAt: const TimestampDateTimeConverter().fromJson(json['createdAt']),
);

Map<String, dynamic> _$ReviewToJson(_Review instance) => <String, dynamic>{
  'id': instance.id,
  'userName': instance.userName,
  'userAvatar': instance.userAvatar,
  'comment': instance.comment,
  'rating': instance.rating,
  'date': const TimestampDateTimeConverter().toJson(instance.date),
  'createdAt': _$JsonConverterToJson<dynamic, DateTime>(
    instance.createdAt,
    const TimestampDateTimeConverter().toJson,
  ),
};

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
