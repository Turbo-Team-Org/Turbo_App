import '../models/favorite.dart';

abstract class IFavorite {
  Future<void> toggleFavorite(Favorite favorite);
  Future<List<Favorite>> getFavorites(int userId);
}
