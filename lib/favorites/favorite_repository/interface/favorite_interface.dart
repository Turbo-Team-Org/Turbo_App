import 'package:turbo/favorites/favorite_repository/models/favorite.dart';

abstract class IFavorite {
  Future<List<Favorite>> getFavorites(String userId);
  Future<void> toggleFavorite(Favorite favorite);
  Future<bool> isFavorite(String userId, String placeId);
  Future<void> addFavorite(String userId, String placeId);
  Future<void> removeFavorite(String userId, String placeId);
}
