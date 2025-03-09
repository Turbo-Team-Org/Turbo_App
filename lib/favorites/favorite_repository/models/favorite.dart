import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorite.freezed.dart';
part 'favorite.g.dart';

@Freezed()
sealed class Favorite with _$Favorite {
  const factory Favorite({required int placeId, required int userId}) =
      _Favorite;

  factory Favorite.fromJson(Map<String, dynamic> json) =>
      _$FavoriteFromJson(json);
}
