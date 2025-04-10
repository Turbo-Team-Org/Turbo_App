import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:turbo/places/place_repository/models/place/place.dart';

part 'favorite.freezed.dart';
part 'favorite.g.dart';

@freezed
sealed class Favorite with _$Favorite {
  const factory Favorite({
    required String id,
    required String userId,
    required String placeId,
    required DateTime date,
    @Default(null) Place? place,
  }) = _Favorite;

  factory Favorite.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final timestamp = data['date'] as Timestamp?;
    final createdAtTimestamp = data['createdAt'] as Timestamp?;

    return Favorite(
      id: doc.id,
      userId: data['userId'] as String,
      placeId: data['placeId'] as String,
      date: (timestamp ?? createdAtTimestamp)?.toDate() ?? DateTime.now(),
      place: null, // Se llenará después de obtener el lugar
    );
  }

  factory Favorite.fromJson(Map<String, dynamic> json) =>
      _$FavoriteFromJson(json);
}

// Conversor personalizado para manejar Timestamp
class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp timestamp) => timestamp.toDate();

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}
